//
//  FirstModule.swift
//  ExampleTransitionHandler
//
//  Created by Alexander Lezya on 27.01.2021.
//

import TransitionHandler

// MARK: - FirstModule

final class FirstModule: AdvancedModule {

    typealias Input = FirstModuleInput
    typealias View = FirstViewController
    typealias Data = String


    static func instantiate(withData data: Data) -> FirstViewController {
        FirstViewController(text: data)
    }
}
