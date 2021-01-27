//
//  FirstViewControllerOutput.swift
//  ExampleTransitionHandler
//
//  Created by Alexander Lezya on 27.01.2021.
//

import TransitionHandler

// MARK: - FirstViewControllerOutput

protocol FirstViewControllerOutput: ModuleOutput {

    /// Button was tapped
    func didTriggerFirstButtonTapped()
}
