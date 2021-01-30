//
//  EnterRouter.swift
//  ExampleTransitionHandler
//
//  Created by Alexander Lezya on 28/01/2021.
//  Copyright © 2021 incetro. All rights reserved.
//

import TransitionHandler

// MARK: - EnterRouter

final class EnterRouter: Router {
}

// MARK: - EnterRouterInput

extension EnterRouter: EnterRouterInput {

    func openFirstModule(moduleOutput: FirstModuleOutput) {
        transitionHandler
            .openModule(FirstModule.self, withData: "You transitioned on First module!")
            .to(.present)
            .then{ moduleInput in
                moduleInput.setModuleOutput(moduleOutput)
            }
    }

    func openSecondModule(moduleOutput: SecondModuleOutput) {
        transitionHandler
            .openModule(SecondModule.self)
            .to(.present)
            .then { moduleInput in
                moduleInput.setModuleOutput(moduleOutput)
            }
    }
}
