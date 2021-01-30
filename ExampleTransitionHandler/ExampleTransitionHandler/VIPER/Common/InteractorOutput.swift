//
//  InteractorOutput.swift
//  TheRun
//
//  Created by incetro on 27/11/2019.
//  Copyright © 2019 Incetro Inc. All rights reserved.
//

import Foundation

// MARK: - InteractorOutput

protocol InteractorOutput {

    /// Method for presenters which receives Interactor's errors
    ///
    /// - Parameter errorMessage: Error message
    func processErrorMessage(_ errorMessage: String)

    /// Method for presenters which receives Interactor's errors
    ///
    /// - Parameter error: some error
    func processError(_ error: Error)
}

extension InteractorOutput {

    /// Method for presenters which receives Interactor's errors
    ///
    /// - Parameter error: some error
    func processError(_ error: Error) {
        processErrorMessage(error.localizedDescription)
    }
}
