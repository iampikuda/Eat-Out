//
//  TestingService.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import Foundation

struct TestingService {
    static var isUnderTest: Bool = {
        #if DEBUG
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil ||
            CommandLine.arguments.contains("--uitesting") {
            return true
        }
        #endif
        return false
    }()

    static var isUnitTest: Bool = {
        #if DEBUG
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            return true
        }
        #endif
        return false
    }()

    static var isUITest: Bool = {
        #if DEBUG
        if CommandLine.arguments.contains("--uitesting") {
            return true
        }
        #endif
        return false
    }()
}
