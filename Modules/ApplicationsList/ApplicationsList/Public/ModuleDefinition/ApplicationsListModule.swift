//
//  ApplicationsListModule.swift
//  ApplicationsList
//

import Common
import UIKit

public final class ApplicationsListModule: Module {
    /// A concrete type of the class that contains all dependencies required by the receiver to work properly.
    /// - SeeAlso: Module.Setup
    public typealias Setup = ApplicationsListModuleSetup

    /// A concrete type of the class that contains the 2way communication interface (to the module and outside of it).
    /// - SeeAlso: Module.Interface
    public typealias Interface = ApplicationsListModuleInterface

    /// - SeeAlso: Module.name
    public static var identifier: String {
        "ApplicationsListModule"
    }

    /// A view controller that will be used outside of the integration as an entry point to the module
    /// which should be attached to the app's view hierarchy.
    var rootViewController: UIViewController {
        flowController.rootViewController
    }

    /// A weak reference to the interface to communicate outside of the module through the single point of contact.
    private weak var interface: ApplicationsListModuleInterface?

    /// Main class managing the flow within this module.
    private let flowController: ApplicationsListFlowController

    /// Initializes the module with setup class containing all dependencies required by the receiver to work properly.
    /// - Parameter setup: An instance of the setup class.
    init(setup: ApplicationsListModuleSetup) {
        flowController = ApplicationsListFlowController(networkService: setup.networkService)
        flowController.delegate = self
    }
}

// MARK: Public

public extension ApplicationsListModule {
    /// Creates entire module with the setup class.
    /// - Parameter setup: Contains dependencies required by the module to work properly.
    /// - Returns: An interface of the created module.
    class func create(setup: ApplicationsListModuleSetup) -> ApplicationsListModuleInterface {
        let module = ApplicationsListModule(setup: setup)
        let interface = ApplicationsListModuleInterface(module: module)
        module.interface = interface
        return interface
    }
}

// MARK: ApplicationsListFlowControllerDelegate

extension ApplicationsListModule: ApplicationsListFlowControllerDelegate {
    func flowController(_ flowController: ApplicationsListFlowController, didPerformFlow flow: ApplicationsListFlow) {
        switch flow {
        case let .selected(application):
            interface?.actionHandler?(self, .selected(application: application))
        case .avatarTapped:
            interface?.actionHandler?(self, .avatarTapped)
        }
    }
}
