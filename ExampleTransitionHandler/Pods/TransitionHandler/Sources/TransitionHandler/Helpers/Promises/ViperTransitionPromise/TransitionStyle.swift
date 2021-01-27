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

    /// Auxililary enum for the transitions to the split navigation controller
    public enum Split {

        /// Detail show action to the split controller
        case detail

        /// Default show to the split controller
        case `default`
    }

    // MARK: - Navigation

    /// Auxililary enum for the transitions to the navigation controller
    public enum Navigation {

        /// Push to the current navigation controller
        case push
        
        /// Pop on the current navigation controller
        case pop

        /// Present to the current navigation controller
        case present

        // swiftlint:disable nesting

        /// Auxililary enum for the styles of replace action
        public enum ReplaceStyle {

            /// Replace all current controllers in navigation
            case all

            /// Replace only last controller in stack of navigation
            case last
        }

        /// Replace in stack of navigation
        case replace(ReplaceStyle)
    }

    // MARK: - Cases

    /// Modal transition for current contoller
    case modal(transition: UIModalTransitionStyle, presentation: UIModalPresentationStyle)

    /// Transition to the navigation controller
    case navigation(style: Navigation)

    /// Transition to the split navigation controller
    case split(style: Split)

    /// Presentation transition for current contoller
    case present
}
