//
//  TransitionStyle.swift
//  Workzilla
//
//  Created by incetro on 27/11/2019.
//  Copyright © 2017 Incetro. All rights reserved.
//

import UIKit

// MARK: - TransitionStyle

/// Auxililary enum for the `transition` style
public enum TransitionStyle {

    // MARK: - Split

    public enum Split {
        case detail
        case `default`
    }

    // MARK: - Navigation

    public enum Navigation {

        case push
        case pop
        case present

        // swiftlint:disable nesting
        public enum ReplaceStyle {
            case all
            case last
        }

        case replace(ReplaceStyle)
    }

    // MARK: - Cases

    case modal(transition: UIModalTransitionStyle, presentation: UIModalPresentationStyle)
    case navigation(style: Navigation)
    case split(style: Split)
    case present
}
