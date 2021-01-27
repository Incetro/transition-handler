//
//  SecondModule.swift
//  ExampleTransitionHandler
//
//  Created by Alexander Lezya on 27.01.2021.
//

import TransitionHandler

// MARK: - SecondModule

final class SecondModule: Module {

    typealias Input = SecondModuleInput
    typealias View = SecondViewController


    static func instantiate() -> SecondViewController {
        SecondViewController()
    }
}
