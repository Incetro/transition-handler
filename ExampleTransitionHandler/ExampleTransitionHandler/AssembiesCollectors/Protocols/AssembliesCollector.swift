//
//  AssembliesCollector.swift
//  ExampleTransitionHandler
//
//  Created by Alexander Lezya on 28.01.2021.
//

import Swinject

private let collectToken = "com.incetro.Daily.Collector"

// MARK: - AssembliesCollector

protocol AssembliesCollector {

    init()

    /// Collect all Application assemblies in container
    ///
    /// - Parameters:
    ///   - container: container for collection
    func collect(inContainer container: Container)
}

extension AssembliesCollector {

    /// Collect all Application assemblies
    func collect() {
        DispatchQueue.once(token: collectToken) {
            self.collect(inContainer: AssembliesHolder.container)
        }
    }

    // Collect all Application assemblies
    static func collect() {
        Self().collect()
    }

    /// Collect all Application assemblies in container
    ///
    /// - Parameters:
    ///   - container: container for collection
    static func collect(in container: Container) {
        Self().collect(inContainer: container)
    }
}
