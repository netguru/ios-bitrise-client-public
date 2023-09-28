//
//  ApplicationDetailsModule.swift
//  ApplicationDetails
//

import Common
import UIKit

public final class ApplicationDetailsModule: Module {
    /// A concrete type of the class that contains all dependencies required by the receiver to work properly.
    /// - SeeAlso: Module.Setup
    public typealias Setup = ApplicationDetailsModuleSetup

    /// A concrete type of the class that contains the 2way communication interface (to the module and outside of it).
    /// - SeeAlso: Module.Interface
    public typealias Interface = ApplicationDetailsModuleInterface

    /// - SeeAlso: Module.name
    public static var identifier: String {
        "ApplicationDetailsModule"
    }

    /// A view controller that will be used outside of the integration as an entry point to the module
    /// which should be attached to the app's view hierarchy.
    let rootViewController: UIViewController

    /// A weak reference to the interface to communicate outside of the module through the single point of contact.
    private weak var interface: ApplicationDetailsModuleInterface?

    /// Initializes the module with setup class containing all dependencies required by the receiver to work properly.
    /// - Parameter setup: An instance of the setup class.
    init(setup: ApplicationDetailsModuleSetup) {
        // ymlViewController will be replaced when ready
        let applicationsDetalsViewController = ApplicationsDetailsViewController(
            buildsViewController: setup.buildsViewController,
            startBuildViewController: setup.startBuildViewController,
            ymlViewController: YMLPreviewViewController(
                application: setup.application,
                networkService: setup.networkService
            )
        )
        rootViewController = applicationsDetalsViewController
        applicationsDetalsViewController.applicationDetailsDelegate = self
    }
}

// MARK: Public

public extension ApplicationDetailsModule {
    /// Creates entire module with the setup class.
    /// - Parameter setup: Contains dependencies required by the module to work properly.
    /// - Returns: An interface of the created module.
    class func create(setup: ApplicationDetailsModuleSetup) -> ApplicationDetailsModuleInterface {
        let module = ApplicationDetailsModule(setup: setup)
        let interface = ApplicationDetailsModuleInterface(module: module)
        module.interface = interface
        return interface
    }
}

extension ApplicationDetailsModule: ApplicationsDetailsViewControllerDelegate {
    func applicationDetails(
        viewController: ApplicationsDetailsViewController,
        didPerformAction action: ApplicationsDetailsViewController.Action
    ) {
        interface?.actionHandler?(self, .moduleViewDismissed)
    }
}
