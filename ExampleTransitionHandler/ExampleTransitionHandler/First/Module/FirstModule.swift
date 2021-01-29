//
//  FirstModule.swift
//  ExampleTransitionHandler
//
//  Created by Alexander Lezya on 28/01/2021.
//  Copyright © 2021 incetro. All rights reserved.
//

import TransitionHandler

// MARK: - FirstModule

final class FirstModule: AdvancedModule {

    // MARK: - Aliases

    typealias Input = FirstModuleInput
    typealias View = FirstViewController
    typealias Data = String

    // MARK: - Module

    static func instantiate(withData data: Data) -> FirstViewController {
        FirstModuleAssembly().obtainViewController(withData: data)
    }
}
