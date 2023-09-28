//
//  XCTestCase+Snapshots.swift
//  BuildsListTests
//

import UIKit
import XCTest
import SnapshotTesting

extension XCTestCase {

    /// Executes snapshot tests of a provided view.
    ///
    /// - Parameters:
    ///   - view: a view to perform snapshot tests on.
    ///   - name: a view name.
    ///   - frame: a view desired frame.
    ///   - precision: a precision which snapshots must match. Defaults to 0.98.
    ///   - shouldCreateTestableView: should the view be wrapped in a view
    ///   - file: a file that triggered the call.
    ///   - functionName: a name of a function that triggered the call.
    ///   - line: a line in file that triggered a call.
    func executeSnapshotTests(
        forView view: UIView,
        named name: String,
        record: Bool = false,
        frame: CGRect = .zero,
        precision: Float = 0.995,
        shouldCreateTestableView: Bool = true,
        file: StaticString = #file,
        functionName: String = #function,
        line: UInt = #line
    ) {
        assertSnapshot(
            matching: view,
            as: .image(precision: precision, size: frame.size),
            named: name,
            record: record,
            file: file,
            testName: functionName,
            line: line
        )
    }
}
