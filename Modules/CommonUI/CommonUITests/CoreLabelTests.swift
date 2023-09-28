//
//  CoreLabelTests.swift
//  CommonUITests
//

import CommonUI
import SnapshotTesting
import XCTest

final class CoreLabelTests: XCTestCase {

    var sut: CoreLabel!

    override func setUp() {
        super.setUp()
        sut = CoreLabel(frame: .zero)
        sut.translatesAutoresizingMaskIntoConstraints = false
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testBaseAppearance() {
        sut.text = "Fixture"
        assertSnapshot(matching: sut, as: .image)
    }
}
