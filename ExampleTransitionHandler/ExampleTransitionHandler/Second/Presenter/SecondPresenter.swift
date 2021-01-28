//
//  SecondPresenter.swift
//  ExampleTransitionHandler
//
//  Created by Alexander Lezya on 28/01/2021.
//  Copyright © 2021 incetro. All rights reserved.
//

import TransitionHandler

// MARK: - SecondPresenter

final class SecondPresenter {
    
    // MARK: - Properties
    
    /// ModuleOutput instance
    weak var output: SecondModuleOutput?

    /// View instance
    weak var view: SecondViewInput?

    /// Router instance
    var router: SecondRouterInput?
}

// MARK: - SecondViewOutput

extension SecondPresenter: SecondViewOutput {

    func didTriggerSecondButtonTapped() {
        output?.changeBackgroundColor()
        router?.close(animated: true)
    }
}

// MARK: - SecondModuleInput

extension SecondPresenter: SecondModuleInput {
    
    func setModuleOutput(_ moduleOutput: ModuleOutput) {
        output = moduleOutput as? SecondModuleOutput
    }
}
