//
//  FirstAssembly.swift
//  ExampleTransitionHandler
//
//  Created by Alexander Lezya on 28/01/2021.
//  Copyright © 2021 incetro. All rights reserved.
//
// swiftlint:disable unused_closure_parameter
// swiftlint:disable closure_parameter_position

import Swinject
import TransitionHandler

// MARK: - FirstModuleAssembly

final class FirstModuleAssembly: CollectableAssembly {

    // MARK: - Initializers

    required init() {

    }

    // MARK: - Useful

    func obtainViewController(withData data: FirstModule.Data) -> FirstViewController {
        container.resolve(FirstViewController.self, argument: data).unwrap()
    }

    // MARK: - Assembly

    func assemble(inContainer container: Container) {

        container.register(FirstViewController.self) { (resolver, data: FirstModule.Data) in
            let controller = FirstViewController(text: data)
            controller.output = resolver.resolve(
                FirstViewOutput.self,
                arguments: controller as FirstViewInput, data
            )
            return controller
        }

        container.register(FirstRouterInput.self) { (resolver, transitionHandler: TransitionHandler) in
            let router = FirstRouter(transitionHandler: transitionHandler)
            return router
        }

        container.register(FirstViewOutput.self) { (resolver, view: FirstViewInput, data: FirstModule.Data) in
            let presenter = FirstPresenter(data: data)
            presenter.view = view
            return presenter
        }.initCompleted { (resolver, viewOutput) in
            if let presenter = viewOutput as? FirstPresenter {
                if let transitionHandler = presenter.view as? TransitionHandler {
                    presenter.router = resolver.resolve(FirstRouterInput.self, argument: transitionHandler)
                }
            }
        }
    }
}
