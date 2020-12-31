//
//  Eat_OutUITests.swift
//  Eat OutUITests
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import XCTest

class EatOutUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()

        continueAfterFailure = true
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }

    func testSearch() {
        let searchTF = app.searchFields[TestIdentifiers.homeSearchField.rawValue]
        searchTF.tap()

        XCTAssert(app.keyboards.element.waitForExistence(timeout: 5))

        app.typeText("sushi")

        let allVisibleCells = app.collectionViews[TestIdentifiers.homeCollectionView.rawValue].cells

        for index in 0 ..< allVisibleCells.count {
            let cell = allVisibleCells.element(boundBy: index)
            XCTAssert(
                cell.staticTexts[TestIdentifiers.homeCollectionViewCellNameLabel.rawValue]
                    .label.lowercased().contains("sushi"),
                "cell at index: \(index), does not comply"
            )
        }
    }

    func testSortAndOrder() {
        let topCell = app.collectionViews[TestIdentifiers.homeCollectionView.rawValue].cells.element(boundBy: 0)

        for index in 0 ..< Sorter.allCases.count {
            let sortCell = app.collectionViews[TestIdentifiers.sortCollectionView.rawValue]
                .cells[TestIdentifiers.sortCell(sorter: Sorter.allCases[index])]

            sortCell.tap()
            let topLabel = topCell.staticTexts[TestIdentifiers.homeCollectionViewCellNameLabel.rawValue].label
            sortCell.tap()

            XCTAssertNotEqual(
                topLabel,
                topCell.staticTexts[TestIdentifiers.homeCollectionViewCellNameLabel.rawValue].label
            )

            sortCell.tap()

            XCTAssertEqual(
                topLabel,
                topCell.staticTexts[TestIdentifiers.homeCollectionViewCellNameLabel.rawValue].label
            )
        }
    }

    func testFavourite() {
        let topCell = app.collectionViews[TestIdentifiers.homeCollectionView.rawValue].cells.element(boundBy: 0)
        let firstImageView = topCell.images[TestIdentifiers.heartImageView.rawValue]
        XCTAssert(firstImageView.waitForExistence(timeout: 2))
        let firstImage = firstImageView.screenshot().pngRepresentation

        topCell.buttons[TestIdentifiers.favouriteButton.rawValue].tap()

        XCTAssertNotEqual(
            firstImage,
            topCell.images[TestIdentifiers.heartImageView.rawValue].screenshot().pngRepresentation
        )

        topCell.buttons[TestIdentifiers.favouriteButton.rawValue].tap()

        XCTAssertEqual(
            firstImage,
            topCell.images[TestIdentifiers.heartImageView.rawValue].screenshot().pngRepresentation
        )
    }

    func testStatusOrder() {
        let orderAheadCell = app.otherElements[TestIdentifiers.cellStatus(.orderAhead)]
        let closedCell = app.otherElements[TestIdentifiers.cellStatus(.closed)]

        XCTAssert(!orderAheadCell.exists)

        while !orderAheadCell.exists {
            app.swipeUp()
        }

        XCTAssert(orderAheadCell.exists)


        XCTAssert(!closedCell.exists)

        while !closedCell.exists {
            app.swipeUp()
        }

        XCTAssert(closedCell.exists)
    }
}
