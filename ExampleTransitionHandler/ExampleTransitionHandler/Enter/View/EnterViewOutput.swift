//
//  EnterViewOutput.swift
//  ExampleTransitionHandler
//
//  Created by Alexander Lezya on 28/01/2021.
//  Copyright © 2021 incetro. All rights reserved.
//

import Foundation

// MARK: - EnterViewOutput

protocol EnterViewOutput: class {

    /// First button was tapped
    func didTriggerFirstButtonTapped()

    /// Second button was tapped
    func didTriggerSecondButtonTapped()
}
