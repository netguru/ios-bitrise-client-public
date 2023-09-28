//
//  GeneralScreensModuleInterface.swift
//  GeneralScreens
//

import Common
import UIKit

public final class GeneralScreensModuleInterface: ModuleInterface {
    /// A concrete type of the enum that contains all actions that goes outside the module.
    /// - SeeAlso: ModuleInterface.Setup
    public typealias Action = GeneralScreensModuleAction

    /// A concrete type of the class which this interface represents.
    /// - SeeAlso: ModuleInterface.AssociatedModule
    public typealias AssociatedModule = GeneralScreensModule

    /// An instance of the module class which this interface represents.
    public let module: GeneralScreensModule

    /// A closure to assign from the outside of the module to establish 2way communication between the caller and the module.
    public var actionHandler: ((AssociatedModule, Action) -> Void)?

    /// - SeeAlso: ModuleInterface.rootViewController
    public var rootViewController: UIViewController? {
        nil
    }

    /// Controller used as the initial controller for the app.
    public var appInitialViewController: UIViewController {
        module.flowController.mainViewController
    }

    public var enterTokenViewController: UIViewController {
        module.flowController.enterTokenController
    }

    public var accountViewController: UIViewController {
        module.flowController.accountDetailsController
    }

    /// Initializes an interface with the module that the receiver should represent.
    /// - Parameter module: An instance of the module class to represent.
    required init(module: AssociatedModule) {
        self.module = module
    }
}
