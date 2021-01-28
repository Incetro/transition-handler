//
//  FirstPresenter.swift
//  ExampleTransitionHandler
//
//  Created by Alexander Lezya on 28/01/2021.
//  Copyright © 2021 incetro. All rights reserved.
//

import TransitionHandler

// MARK: - FirstPresenter

final class FirstPresenter {
    
    // MARK: - Properties
    
    /// ModuleOutput instance
    weak var output: FirstModuleOutput?

    /// View instance
    weak var view: FirstViewInput?

    /// Router instance
    var router: FirstRouterInput?

    /// Initialized data
    private let data: FirstModule.Data

    // MARK: - Initializers

    /// Description
    /// - Parameter enterModuleInput: enterModuleInput description
    init(data: FirstModule.Data) {
        self.data = data
    }
}

// MARK: - FirstViewOutput

extension FirstPresenter: FirstViewOutput {

    func didTriggerFirstButtonTapped() {
        output?.changeTitleText()
        router?.close(animated: true)
    }
}

// MARK: - FirstModuleInput

extension FirstPresenter: FirstModuleInput {
    
    func setModuleOutput(_ moduleOutput: ModuleOutput) {
        output = moduleOutput as? FirstModuleOutput
    }
}
