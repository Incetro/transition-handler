//
//  SecondViewControllerOutput.swift
//  ExampleTransitionHandler
//
//  Created by Alexander Lezya on 27.01.2021.
//

import TransitionHandler

// MARK: - SecondViewControllerOutput

protocol SecondViewControllerOutput: ModuleOutput {

    /// Button was tapped
    func didTriggerSecondButtonTapped()
}
