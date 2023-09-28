//
//  ApplicationDetailsModuleInterface.swift
//  ApplicationDetails
//

import Common
import UIKit

public final class ApplicationDetailsModuleInterface: ModuleInterface {
    /// A concrete type of the enum that contains all actions that goes outside the module.
    /// - SeeAlso: ModuleInterface.Setup
    public typealias Action = ApplicationDetailsModuleAction

    /// A concrete type of the class which this interface represents.
    /// - SeeAlso: ModuleInterface.AssociatedModule
    public typealias AssociatedModule = ApplicationDetailsModule

    /// An instance of the module class which this interface represents.
    public let module: ApplicationDetailsModule

    /// A closure to assign from the outside of the module to establish 2way communication between the caller and the module.
    public var actionHandler: ((AssociatedModule, Action) -> Void)?

    /// - SeeAlso: ModuleInterface.rootViewController
    public var rootViewController: UIViewController? {
        module.rootViewController
    }

    /// Initializes an interface with the module that the receiver should represent.
    /// - Parameter module: An instance of the module class to represent.
    required init(module: AssociatedModule) {
        self.module = module
    }
}
