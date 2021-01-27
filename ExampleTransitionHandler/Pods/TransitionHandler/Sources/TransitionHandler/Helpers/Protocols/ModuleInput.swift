//
//  ModuleInput.swift
//  Workzilla
//
//  Created by incetro on 27/11/2019.
//  Copyright © 2017 Incetro. All rights reserved.
//

import Foundation

// MARK: - ModuleInput

/// Input `layer` for communication between modules and most often it is a presenter 
public protocol ModuleInput: class {

    /// Set module output for the current module
    ///
    /// - Parameter moduleOutput: ModuleOutput instance
    func setModuleOutput(_ moduleOutput: ModuleOutput)
}

extension ModuleInput {

    public func setModuleOutput(_ moduleOutput: ModuleOutput) {
    }
}
