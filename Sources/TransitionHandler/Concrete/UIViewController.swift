//
//  UIViewController.swift
//  Workzilla
//
//  Created by incetro on 27/11/2019.
//  Copyright © 2017 Incetro. All rights reserved.
//

import UIKit

// MARK: - TransitionHandler

extension UIViewController: TransitionHandler {

    /// Open the desired module
    public func open(_ viewController: UIViewController) -> SeamlessTransitionPromise {
        let promise = SeamlessTransitionPromise(
            source: self,
            destination: viewController
        )
        promise.promise { [weak self, weak viewController] in
            guard let self, let viewController else { return }
            self.present(viewController, animated: true, completion: nil)
        }
        return promise
    }

    /// Close current module
    public func closeCurrentModule() -> CloseTransitionPromise {
        let close = CloseTransitionPromise(source: self)
        close.promise { [unowned self] in
            if let parent = self.parent {
                if let navigationController = parent as? UINavigationController {
                    if navigationController.children.count > 1 {
                        navigationController.popViewController(animated: close.isAnimated)
                    } else if let presentedViewController = navigationController.presentedViewController {
                        presentedViewController.dismiss(animated: close.isAnimated)
                    } else if navigationController.children.count == 1 {
                        navigationController.dismiss(animated: close.isAnimated)
                    }
                } else {
                    self.removeFromParent()
                    self.view.removeFromSuperview()
                }
            } else if self.presentingViewController != nil {
                self.dismiss(animated: close.isAnimated)
            }
        }
        return close
    }
}
