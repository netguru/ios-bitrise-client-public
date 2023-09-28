//
//  GeneralScreensModule.swift
//  GeneralScreens
//

import Common
import UIKit

public final class GeneralScreensModule: Module {
    /// A concrete type of the class that contains all dependencies required by the receiver to work properly.
    /// - SeeAlso: Module.Setup
    public typealias Setup = GeneralScreensModuleSetup

    /// A concrete type of the class that contains the 2way communication interface (to the module and outside of it).
    /// - SeeAlso: Module.Interface
    public typealias Interface = GeneralScreensModuleInterface

    /// - SeeAlso: Module.name
    public static var identifier: String {
        "GeneralScreensModule"
    }

    /// A weak reference to the interface to communicate outside of the module through the single point of contact.
    private weak var interface: GeneralScreensModuleInterface?

    /// Main class managing the flow within this module.
    let flowController: GeneralScreensFlowController

    /// Initializes the module with setup class containing all dependencies required by the receiver to work properly.
    /// - Parameter setup: An instance of the setup class.
    init(setup: GeneralScreensModuleSetup) {
        flowController = GeneralScreensFlowController(
            credentialsStorage: setup.credentialsStorage,
            userStorage: setup.userStorage
        )
        flowController.delegate = self
    }
}

// MARK: Public

public extension GeneralScreensModule {
    /// Creates entire module with the setup class.
    /// - Parameter setup: Contains dependencies required by the module to work properly.
    /// - Returns: An interface of the created module.
    class func create(setup: GeneralScreensModuleSetup) -> GeneralScreensModuleInterface {
        let module = GeneralScreensModule(setup: setup)
        let interface = GeneralScreensModuleInterface(module: module)
        module.interface = interface
        return interface
    }
}

extension GeneralScreensModule: GeneralScreensFlowControllerDelegate {
    func flowController(
        _ flowController: GeneralScreensFlowController,
        didPerformFlow flow: GeneralScreensModuleAction
    ) {
        interface?.actionHandler?(self, flow)
    }
}
