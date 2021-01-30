//
//  ViewOutput.swift
//  TheRun
//
//  Created by incetro on 27/11/2019.
//  Copyright © 2019 Incetro Inc. All rights reserved.
//

import Foundation

// MARK: - ViewOutput

protocol ViewOutput {

    /// Said to view output that it's necesarry to
    /// update current view state with some new data
    func requestViewUpdate()
}
