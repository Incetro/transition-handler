//
//  DispatchQueue.swift
//  ExampleTransitionHandler
//
//  Created by Alexander Lezya on 28.01.2021.
//

import Foundation

// MARK: - DispatchQueue

extension DispatchQueue {

    private static var _onceTracker: [String] = []

    static func once(token: String, block: () -> Void) {
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        if _onceTracker.contains(token) {
            return
        }
        _onceTracker.append(token)
        block()
    }

    static func once(object: AnyObject, block: () -> Void) {
        let token = ObjectIdentifier(object).debugDescription
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        if _onceTracker.contains(token) {
            return
        }
        _onceTracker.append(token)
        block()
    }
}
