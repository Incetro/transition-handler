//
//  EnterViewInput.swift
//  ExampleTransitionHandler
//
//  Created by Alexander Lezya on 28/01/2021.
//  Copyright © 2021 incetro. All rights reserved.
//

import UIKit

// MARK: - EnterViewInput

protocol EnterViewInput: ViewInput {

    /// Change title text
    func changeTitleText(_ text: String)

    /// Change background color
    func changeBackgroundColor(_ color: UIColor)
}
