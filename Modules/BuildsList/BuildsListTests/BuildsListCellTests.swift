//
//  BuildsListCellTests.swift
//  BuildsListTests
//

import Foundation
import XCTest
import SnapshotTesting
@testable import BuildsList

final class BuildsListCellTests: XCTestCase {
    var sut: BuildsListCell!
    var workflow = "Pull-request"
    var startTime: Date = {
        let components = DateComponents(
            calendar: Calendar(identifier: Calendar.Identifier.iso8601),
            timeZone: TimeZone(identifier: "gmt"),
            era: 0,
            year: 2022,
            month: 1,
            day: 1,
            hour: 10,
            minute: 10,
            second: 10,
            nanosecond: 10
        )
        return components.date!
    }()

    override func setUpWithError() throws {
        sut = BuildsListCell(style: .default, reuseIdentifier: "")
    }

    func testRenderingInProgress() throws {
        sut.dateProvider = MockDateProvider.self
        sut.configure(
            state: .inProgress,
            workflowName: workflow,
            startTime: startTime,
            endTime: nil
        )

        executeSnapshotTests(
            forView: sut,
            named: "BuildsListCell_inProgress",
            frame: CGRect(x: 0, y: 0, width: 390, height: 75)
        )
    }

    func testRenderingCompletedSuccessfully() throws {
        sut.configure(
            state: .completedSuccessfully,
            workflowName: workflow,
            startTime: startTime,
            endTime: startTime.addingTimeInterval(78)
        )

        executeSnapshotTests(
            forView: sut,
            named: "BuildsListCell_completedSuccessfully",
            frame: CGRect(x: 0, y: 0, width: 390, height: 75)
        )
    }

    func testRenderingFailed() throws {
        sut.configure(
            state: .failed,
            workflowName: workflow,
            startTime: startTime,
            endTime: startTime.addingTimeInterval(78)
        )

        executeSnapshotTests(
            forView: sut,
            named: "BuildsListCell_failed",
            frame: CGRect(x: 0, y: 0, width: 390, height: 75)
        )
    }
}

private struct MockDateProvider: CellDateProvider {
    static var current: Date {
        let components = DateComponents(
            calendar: Calendar(identifier: Calendar.Identifier.iso8601),
            timeZone: TimeZone(identifier: "gmt"),
            era: 0,
            year: 2022,
            month: 1,
            day: 1,
            hour: 10,
            minute: 15,
            second: 47,
            nanosecond: 10
        )
        return components.date!
    }
}
