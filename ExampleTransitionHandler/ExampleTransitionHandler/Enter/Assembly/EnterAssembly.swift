//
//  EnterAssembly.swift
//  ExampleTransitionHandler
//
//  Created by Alexander Lezya on 28/01/2021.
//  Copyright © 2021 incetro. All rights reserved.
//
// swiftlint:disable unused_closure_parameter
// swiftlint:disable closure_parameter_position

import TransitionHandler
import Swinject

// MARK: - EnterModuleAssembly

final class EnterModuleAssembly: CollectableAssembly {

    // MARK: - Initializers

    required init() {

    }

    // MARK: - Useful

    func obtainViewController() -> EnterViewController {
        container.resolve(EnterViewController.self).unwrap()
    }

    // MARK: - Assembly

    func assemble(inContainer container: Container) {

        container.register(EnterViewController.self) { resolver in
            let controller = EnterViewController()
            controller.output = resolver.resolve(
                EnterViewOutput.self,
                argument: controller as EnterViewInput
            )
            return controller
        }

        container.register(EnterRouterInput.self) { (resolver, transitionHandler: TransitionHandler) in
            let router = EnterRouter(transitionHandler: transitionHandler)
            return router
        }

        container.register(EnterViewOutput.self) { (resolver, view: EnterViewInput) in
            let presenter = EnterPresenter()
            presenter.view = view
            return presenter
        }.initCompleted { (resolver, viewOutput) in
            if let presenter = viewOutput as? EnterPresenter {
                if let transitionHandler = presenter.view as? TransitionHandler {
                    presenter.router = resolver.resolve(EnterRouterInput.self, argument: transitionHandler)
                }
            }
        }
    }
}
