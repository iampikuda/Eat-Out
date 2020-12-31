//
//  HomeViewControllerSnapshotTests.swift
//  Eat OutTests
//
//  Created by Damisi Pikuda on 31/12/2020.
//

import XCTest
import SnapshotTesting

@testable import Eat_Out

final class HomeViewControllerSnapshotTests: EOSnapshotTest {
    func testRendering() {
        let vm = HomeViewModel()
        let sortVM = SortViewModel()

        for device in self.snapshotDevices {
            let vc = HomeViewController(viewModel: vm, sortViewModel: sortVM, screenSize: device.screenSize)
            let nav = UINavigationController(rootViewController: vc)

            assertSnapshot(
                matching: nav,
                as: .image(on: device.portraitConfig),
                named: "\(String(describing: HomeViewController.self))-\(device.name)"
            )
        }
    }

    func testRendering_long() {
        let vm = HomeViewModel()
        let sortVM = SortViewModel()

        for device in self.snapshotDevices {
            let vc = HomeViewController(viewModel: vm, sortViewModel: sortVM, screenSize: device.screenSize)
            let nav = UINavigationController(rootViewController: vc)

            assertSnapshot(
                matching: nav,
                as: .image(on: device.portraitConfig, size: CGSize(width: device.screenSize.width, height: 6000)),
                named: "\(String(describing: HomeViewController.self))-long-\(device.name)"
            )
        }
    }
}
