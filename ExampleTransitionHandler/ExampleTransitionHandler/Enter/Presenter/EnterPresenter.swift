//
//  EnterPresenter.swift
//  ExampleTransitionHandler
//
//  Created by Alexander Lezya on 28/01/2021.
//  Copyright © 2021 incetro. All rights reserved.
//

import TransitionHandler

// MARK: - EnterPresenter

final class EnterPresenter {
    
    // MARK: - Properties
    
    /// ModuleOutput instance
    weak var output: EnterModuleOutput?

    /// View instance
    weak var view: EnterViewInput?

    /// Router instance
    var router: EnterRouterInput?
}

// MARK: - EnterViewOutput

extension EnterPresenter: EnterViewOutput {

    func didTriggerFirstButtonTapped() {
        router?.openFirstModule(moduleOutput: self)
    }

    func didTriggerSecondButtonTapped() {
        router?.openSecondModule(moduleOutput: self)
    }
}

// MARK: - EnterModuleInput

extension EnterPresenter: EnterModuleInput {
    
    func setModuleOutput(_ moduleOutput: ModuleOutput) {
        output = moduleOutput as? EnterModuleOutput
    }
}

// MARK: - FirstModuleOutput

extension EnterPresenter: FirstModuleOutput {

    func changeTitleText() {
        view?.changeTitleText("You tapped the button of the First module")
    }
}

// MARK: - SecondModuleOutput

extension EnterPresenter: SecondModuleOutput {

    func changeBackgroundColor() {
        view?.changeTitleText("Welcome to TransitionHandler example!")
        view?.changeBackgroundColor(
            UIColor(
                red: .random(in: 0.45...0.8),
                green: .random(in: 0.45...0.8),
                blue: .random(in: 0.45...0.8),
                alpha: 1
            )
        )
    }
}
