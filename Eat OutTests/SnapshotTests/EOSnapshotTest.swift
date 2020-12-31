//
//  EOSnapshotTest.swift
//  Eat OutTests
//
//  Created by Damisi Pikuda on 31/12/2020.
//

import XCTest
import SnapshotTesting

@testable import Eat_Out

public struct PhoneForSnapshotTesting {
    var screenSize: CGSize
    let name: String
    let portraitConfig: ViewImageConfig
    let deviceType: TestingDevice

    init(testingDevice: TestingDevice) {
        if testingDevice.portraitConfig.size == nil {
            assertionFailure("ScreenSize nil for \(testingDevice.rawValue)")
        }

        // swiftlint:disable:next force_unwrapping
        self.screenSize = testingDevice.portraitConfig.size!
        self.portraitConfig = testingDevice.portraitConfig.self
        self.name = testingDevice.rawValue
        self.deviceType = testingDevice
    }
}

enum TestingDevice: String {
    case iPhoneSe
    case iPhone8
    case iPhoneXsMax = "iPhoneMax"
    case unknown

    init(rawValue: String) {
        switch rawValue {
        case "iPhoneSe": self = .iPhoneSe
        case "iPhone8": self = .iPhone8
        case "iPhoneMax": self = .iPhoneXsMax
        default:
            assertionFailure("iPhone device not added to TestingDevice. Please add.")
            self = .unknown
        }
    }

    fileprivate var portraitConfig: ViewImageConfig {
        switch rawValue {
        case "iPhoneSe": return ViewImageConfig.iPhoneSe(.portrait)
        case "iPhone8": return ViewImageConfig.iPhone8(.portrait)
        case "iPhoneMax": return ViewImageConfig.iPhoneXsMax(.portrait)
        default:
            assertionFailure("iPhone device not added to TestingDevice. Please add.")
            return ViewImageConfig.iPhone8(.portrait)
        }
    }
}

class EOSnapshotTest: XCTestCase {
    final let iPhoneSe = PhoneForSnapshotTesting(testingDevice: .iPhoneSe)
    final let iPhone8 = PhoneForSnapshotTesting(testingDevice: .iPhone8)
    final let iPhoneMax = PhoneForSnapshotTesting(testingDevice: .iPhoneXsMax)

    final var snapshotDevices: [PhoneForSnapshotTesting] {
        return [iPhoneSe, iPhone8, iPhoneMax]
    }

    override func setUp() {
        diffTool = "ksdiff"
        super.setUp()
    }
}
