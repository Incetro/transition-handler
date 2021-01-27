//
//  Module.swift
//  Workzilla
//
//  Created by incetro on 27/11/2019.
//  Copyright © 2017 Incetro. All rights reserved.
//

import UIKit

// MARK: - Module

/// Module is an independent element of the application (screen)
/// that doesn't depend on the architecture and implementation of another modules
public protocol Module {

    /// Current module's view type
    associatedtype View

    /// ModuleInput type
    associatedtype Input

    /// Instantiate module as a view
    ///
    /// - Returns: new module instance
    static func instantiate() -> View
}

// MARK: - AdvancedModule

/// Same as `Module` but with more complex data objects inside
public protocol AdvancedModule: Module {

    /// Current module's Data type
    associatedtype Data

    /// Instantiate module as a view with data
    /// - Parameter data: initial module data
    static func instantiate(withData data: Data) -> View
}

extension AdvancedModule {

    public static func instantiate() -> View {
        fatalError("You should use `instantiate(withData:)` method in advanced modules")
    }
}
