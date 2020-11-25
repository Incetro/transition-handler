//
//  CloseTransitionPromise.swift
//  TransitionHandler
//
//  Created by incetro on 27/11/2019.
//  Copyright © 2019 incetro. All rights reserved.
//

import UIKit

// MARK: - CloseTransitionPromise

public final class CloseTransitionPromise {

    // MARK: - Properties

    /// True if need to animate transition
    var isAnimated: Bool {
        animated
    }

    /// Source controller which trigger the transition
    private unowned var source: UIViewController

    /// Controller to use as `destination` if `conditionPop`returns true
    private var foundViewController: UIViewController?

    /// True if need to animate presentation of controller
    private var animated = true

    /// Promise that contains closure with setups
    private var promise: PromiseAction?

    // MARK: - Initializers

    // Initilization with source and destination
    ///
    /// - Parameters:
    ///   - source: Source UIViewController
    init(source: UIViewController) {
        self.source = source
    }

    // MARK: - Useful

    // Set promise for current transition
    public func promise(_ promise: @escaping PromiseAction) {
        self.promise = promise
    }

    // Set animate property for current transition
    public func animate(_ animate: Bool) -> CloseTransitionPromise {
        animated = animate
        return self
    }

    // swiftlint:disable cyclomatic_complexity

    /// Configures the current promise with the specific `transition` style
    ///
    /// This method allows you to use the `CloseTransitionStyle` auxiliary enum to set the transition type
    /// for your promise if default style isn't what do you want
    ///
    /// - Returns: Current promise
    public func with(_ style: CloseTransitionStyle) -> CloseTransitionPromise {
        promise = nil
        promise = { [weak self] in
            guard let source = self?.source, let animated = self?.animated else {
                throw TransitionHandlerError.nilController("Source")
            }
            switch style {
            case .default:
                if source.presentingViewController != nil {
                    source.dismiss(animated: animated)
                } else {
                    source.removeFromParent()
                    source.view?.removeFromSuperview()
                }
            case .navigation(style: let navigationStyle):
                guard let navigationController = source.parent as? UINavigationController else {
                    throw TransitionHandlerError.nilController("Navigation")
                }
                switch navigationStyle {
                case .toRoot:
                    navigationController.popToRootViewController(animated: animated)
                case .simplePop:
                    if navigationController.children.count > 1 {
                        navigationController.popViewController(animated: animated)
                    } else {
                        throw TransitionHandlerError.custom("Can't make `simplePop` because UINavigationController children count < 2")
                    }
                case .conditionPop:
                    guard let found = self?.foundViewController else {
                        throw TransitionHandlerError.nilController("Condition")
                    }
                    navigationController.popToViewController(found, animated: animated)
                case .pop(to: let controller):
                    navigationController.popToViewController(controller, animated: animated)
                case .forcePop(to: let controller):
                    if navigationController.children.count > 1 {
                        var controllers = navigationController.children
                        controllers.insert(controller, at: controllers.count - 1)
                        navigationController.setViewControllers(controllers, animated: false)
                        navigationController.popViewController(animated: animated)
                    } else {
                        throw TransitionHandlerError.custom("Can't make `forcePop` because UINavigationController children count < 2")
                    }
                }
            }
        }
        return self
    }

    /// Сonfigure the current promise with the first controller found by condition
    ///
    /// - Returns: Current promise
    public func conditionPop(_ condition: (UIViewController) -> Bool) -> CloseTransitionPromise {
        let navigationController = source
            .navigationController
            .unwrap(TransitionHandlerError.nilController("Navigation"))
        let found = navigationController.children.first {
            condition($0)
        }
        foundViewController = found
        return self
    }

    /// Make transition
    public func perform() {
        do {
            try self.promise?()
        } catch {
            print(error.localizedDescription)
        }
    }
}
