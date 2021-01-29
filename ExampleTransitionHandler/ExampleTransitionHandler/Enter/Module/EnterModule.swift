//
//  EnterModule.swift
//  ExampleTransitionHandler
//
//  Created by Alexander Lezya on 28/01/2021.
//  Copyright © 2021 incetro. All rights reserved.
//

import TransitionHandler

// MARK: - EnterModule

final class EnterModule: Module {

    // MARK: - Aliases

    typealias Input = EnterModuleInput
    typealias View = EnterViewController

    // MARK: - Module

    static func instantiate() -> EnterViewController {
        EnterModuleAssembly().obtainViewController()
    }
}
