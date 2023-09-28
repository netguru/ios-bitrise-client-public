//
//  StartBuildModule.swift
//  StartBuild
//

import Common
import UIKit

public final class StartBuildModule: Module {
    /// A concrete type of the class that contains all dependencies required by the receiver to work properly.
    /// - SeeAlso: Module.Setup
    public typealias Setup = StartBuildModuleSetup

    /// A concrete type of the class that contains the 2way communication interface (to the module and outside of it).
    /// - SeeAlso: Module.Interface
    public typealias Interface = StartBuildModuleInterface

    /// - SeeAlso: Module.name
    public static var identifier: String {
        "StartBuildModule"
    }

    /// A view controller that will be used outside of the integration as an entry point to the module
    /// which should be attached to the app's view hierarchy.
    let rootViewController: UIViewController

    /// A weak reference to the interface to communicate outside of the module through the single point of contact.
    private weak var interface: StartBuildModuleInterface?

    /// Initializes the module with setup class containing all dependencies required by the receiver to work properly.
    /// - Parameter setup: An instance of the setup class.
    init(setup: StartBuildModuleSetup) {
        rootViewController = MainViewController(
            networkService: setup.networkService,
            application: setup.application
        )
    }
}

// MARK: Public

public extension StartBuildModule {
    /// Creates entire module with the setup class.
    /// - Parameter setup: Contains dependencies required by the module to work properly.
    /// - Returns: An interface of the created module.
    class func create(setup: StartBuildModuleSetup) -> StartBuildModuleInterface {
        let module = StartBuildModule(setup: setup)
        let interface = StartBuildModuleInterface(module: module)
        module.interface = interface
        return interface
    }
}
