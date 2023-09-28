//
//  BuildsListModule.swift
//  BuildsList
//

import Common
import UIKit

public final class BuildsListModule: Module {
    /// A concrete type of the class that contains all dependencies required by the receiver to work properly.
    /// - SeeAlso: Module.Setup
    public typealias Setup = BuildsListModuleSetup

    /// A concrete type of the class that contains the 2way communication interface (to the module and outside of it).
    /// - SeeAlso: Module.Interface
    public typealias Interface = BuildsListModuleInterface

    /// - SeeAlso: Module.name
    public static var identifier: String {
        "BuildsListModule"
    }

    /// A view controller that will be used outside of the integration as an entry point to the module
    /// which should be attached to the app's view hierarchy.
    let rootViewController: UIViewController

    /// A weak reference to the interface to communicate outside of the module through the single point of contact.
    private weak var interface: BuildsListModuleInterface?

    private let flowController: BuildsListFlowController

    /// Initializes the module with setup class containing all dependencies required by the receiver to work properly.
    /// - Parameter setup: An instance of the setup class.
    init(setup: BuildsListModuleSetup) {
        flowController = BuildsListFlowController(
            application: setup.application,
            networkService: setup.networkService
        )
        rootViewController = flowController.rootViewController
    }
}

// MARK: Public

public extension BuildsListModule {
    /// Creates entire module with the setup class.
    /// - Parameter setup: Contains dependencies required by the module to work properly.
    /// - Returns: An interface of the created module.
    class func create(setup: BuildsListModuleSetup) -> BuildsListModuleInterface {
        let module = BuildsListModule(setup: setup)
        let interface = BuildsListModuleInterface(module: module)
        module.interface = interface
        return interface
    }
}
