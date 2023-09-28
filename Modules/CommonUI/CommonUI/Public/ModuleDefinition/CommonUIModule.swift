//
//  CommonUIModule.swift
//  CommonUI
//

import Common
import UIKit

public final class CommonUIModule: Module {
    /// A concrete type of the class that contains all dependencies required by the receiver to work properly.
    /// - SeeAlso: Module.Setup
    public typealias Setup = CommonUIModuleSetup

    /// A concrete type of the class that contains the 2way communication interface (to the module and outside of it).
    /// - SeeAlso: Module.Interface
    public typealias Interface = CommonUIModuleInterface

    /// - SeeAlso: Module.name
    public static var identifier: String {
        "CommonUIModule"
    }

    /// A weak reference to the interface to communicate outside of the module through the single point of contact.
    private weak var interface: CommonUIModuleInterface?

    /// Initializes the module with setup class containing all dependencies required by the receiver to work properly.
    /// - Parameter setup: An instance of the setup class.
    init(setup: CommonUIModuleSetup) {
        setup.setupFonts()
    }
}

// MARK: Public

public extension CommonUIModule {
    /// Creates entire module with the setup class.
    /// - Parameter setup: Contains dependencies required by the module to work properly.
    /// - Returns: An interface of the created module.
    class func create(setup: CommonUIModuleSetup) -> CommonUIModuleInterface {
        let module = CommonUIModule(setup: setup)
        let interface = CommonUIModuleInterface(module: module)
        module.interface = interface
        return interface
    }
}
