//
//  AssembliesHolder.swift
//  ExampleTransitionHandler
//
//  Created by Alexander Lezya on 28.01.2021.
//

import Swinject

// MARK: - AssembliesHolder

final class AssembliesHolder {

    // MARK: - Properties

    /// Singleton container
    static var container: Container {
        AssembliesHolder.instance.container
    }

    /// Private singleton instance
    private static let instance = AssembliesHolder()

    /// Global DI container
    private let container: Container

    // MARK: - Initializers

    /// Default initializer
    private init() {
        container = Container()
    }
}
