//
//  BitriseAuthenticationModule.swift
//  BitriseAuthentication
//

import Common
import UIKit

public final class BitriseAuthenticationModule: Module {
    /// A concrete type of the class that contains all dependencies required by the receiver to work properly.
    /// - SeeAlso: Module.Setup
    public typealias Setup = BitriseAuthenticationModuleSetup

    /// A concrete type of the class that contains the 2way communication interface (to the module and outside of it).
    /// - SeeAlso: Module.Interface
    public typealias Interface = BitriseAuthenticationModuleInterface

    /// - SeeAlso: Module.name
    public static var identifier: String {
        "BitriseAuthenticationModule"
    }

    /// A view controller that will be used outside of the integration as an entry point to the module
    /// which should be attached to the app's view hierarchy.
    lazy var rootViewController: UIViewController = {
        let controller = WebViewController()
        controller.delegate = self
        return controller
    }()

    /// A weak reference to the interface to communicate outside of the module through the single point of contact.
    private weak var interface: BitriseAuthenticationModuleInterface?

    /// Initializes the module with setup class containing all dependencies required by the receiver to work properly.
    /// - Parameter setup: An instance of the setup class.
    init(setup: BitriseAuthenticationModuleSetup) {
        // empty by design
    }
}

// MARK: Public

public extension BitriseAuthenticationModule {
    /// Creates entire module with the setup class.
    /// - Parameter setup: Contains dependencies required by the module to work properly.
    /// - Returns: An interface of the created module.
    class func create(setup: BitriseAuthenticationModuleSetup) -> BitriseAuthenticationModuleInterface {
        let module = BitriseAuthenticationModule(setup: setup)
        let interface = BitriseAuthenticationModuleInterface(module: module)
        module.interface = interface
        return interface
    }
}

extension BitriseAuthenticationModule: WebViewControllerDelegate {
    func webViewController(viewController: WebViewController, didPerformAction action: WebViewController.Action) {
        interface?.actionHandler?(self, .tokenCreated)
    }
}
