//
//  BuildConfigs.swift
//  My Mind
//
//  Created by Seemanta Biswas on 2020-11-23.
//

import Foundation

struct BuildConfig {
    
    static func isRunningTests() -> Bool {
        let environment = ProcessInfo().environment
        return environment["TESTING"] != nil
    }
    
    static var loadFromLocalJson: Bool {
        return false
    }
}
