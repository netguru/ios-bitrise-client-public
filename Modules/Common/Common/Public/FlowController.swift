//
//  FlowController.swift
//  Common
//

import UIKit

public protocol FlowController {
    /// The root view controller of the current flow.
    var rootViewController: UIViewController { get }
}
