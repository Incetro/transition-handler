//
//  SecondAssembly.swift
//  ExampleTransitionHandler
//
//  Created by Alexander Lezya on 28/01/2021.
//  Copyright © 2021 incetro. All rights reserved.
//
// swiftlint:disable unused_closure_parameter
// swiftlint:disable closure_parameter_position

import Swinject
import TransitionHandler

// MARK: - SecondModuleAssembly

final class SecondModuleAssembly: CollectableAssembly {

    // MARK: - Initializers

    required init() {

    }

    // MARK: - Useful

    func obtainViewController() -> SecondViewController {
        return container.resolve(SecondViewController.self).unwrap()
    }

    // MARK: - Assembly

    func assemble(inContainer container: Container) {

        container.register(SecondViewController.self) { resolver in
            let controller = SecondViewController()
            controller.output = resolver.resolve(SecondViewOutput.self, argument: controller as SecondViewInput)
            return controller
        }

        container.register(SecondRouterInput.self) { (resolver, transitionHandler: TransitionHandler) in
            let router = SecondRouter(transitionHandler: transitionHandler)
            return router
        }

        container.register(SecondViewOutput.self) { (resolver, view: SecondViewInput) in
            let presenter = SecondPresenter()
            presenter.view = view
            return presenter
        }.initCompleted { (resolver, viewOutput) in
            if let presenter = viewOutput as? SecondPresenter {
                if let transitionHandler = presenter.view as? TransitionHandler {
                    presenter.router = resolver.resolve(SecondRouterInput.self, argument: transitionHandler)
                }
            }
        }
    }
}
