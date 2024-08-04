//
//  TransitionPromise.swift
//  Workzilla
//
//  Created by incetro on 27/11/2019.
//  Copyright © 2017 Incetro. All rights reserved.
//

import UIKit

public typealias PromiseAction = () throws -> Void

// MARK: - TransitionPromise

public class TransitionPromise {

    // MARK: Properties

    /// Source controller which trigger the transition
    unowned var source: UIViewController

    /// The controller that is the target of the transition
    var destination: UIViewController?

    /// Promise that contains closure with setups
    var promise: PromiseAction?

    /// True if need to animate presentation of source controller
    private(set) var animated = true

    // MARK: - Initializers

    /// Initilization with source and destination
    ///
    /// - Parameters:
    ///   - source: Source UIViewController
    ///   - destination: Destination UIViewController
    ///   - type: ModuleInput type
    init(source: UIViewController, destination: UIViewController?) {
        self.source = source
        self.destination = destination
    }

    // MARK: - Useful

    /// Set animate property
    ///
    /// - Parameter animate: animate property
    /// - Returns: Current promise
    public func animate(_ animate: Bool) -> Self {
        self.animated = animate
        return self
    }

    /// Setup destination
    ///
    /// - Parameter block: setup block
    /// - Returns: Current promise
    public func destination(_ block: (UIViewController) -> Void) -> Self {
        let destination = destination.unwrap(TransitionHandlerError.nilController("Destination"))
        block(destination)
        return self
    }

    /// Make transition
    public func perform() {
        do {
            try promise?()
        } catch {
            print(error.localizedDescription)
        }
    }

    /// Replace promise
    ///
    /// - Parameter completion: Current promise
    public func promise( _ promise: @escaping PromiseAction) {
        self.promise = promise
    }
}
