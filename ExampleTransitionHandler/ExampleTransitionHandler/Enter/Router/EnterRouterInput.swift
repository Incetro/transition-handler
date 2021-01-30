//
//  EnterRouterInput.swift
//  ExampleTransitionHandler
//
//  Created by Alexander Lezya on 28/01/2021.
//  Copyright © 2021 incetro. All rights reserved.
//

import Foundation

// MARK: - EnterRouterInput

protocol EnterRouterInput: class, RouterInput {

    /// Open first module
    /// - Parameter moduleOutput: module output instance
    func openFirstModule(moduleOutput: FirstModuleOutput)

    /// Open second module
    /// - Parameter moduleOutput: module output instance
    func openSecondModule(moduleOutput: SecondModuleOutput)
}
