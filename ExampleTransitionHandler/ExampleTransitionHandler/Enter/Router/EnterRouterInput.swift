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

    func openFirstModule(moduleOutput: FirstModuleOutput)

    func openSecondModule(moduleOutput: SecondModuleOutput)
}
