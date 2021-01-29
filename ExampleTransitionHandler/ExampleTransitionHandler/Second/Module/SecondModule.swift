//
//  SecondModule.swift
//  ExampleTransitionHandler
//
//  Created by Alexander Lezya on 28/01/2021.
//  Copyright © 2021 incetro. All rights reserved.
//

import TransitionHandler

// MARK: - SecondModule

final class SecondModule: Module {

    // MARK: - Aliases

    typealias Input = SecondModuleInput
    typealias View = SecondViewController

    // MARK: - Module

    static func instantiate() -> SecondViewController {
        SecondModuleAssembly().obtainViewController()
    }
}
