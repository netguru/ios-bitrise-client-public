//
//  CommonModule.swift
//  Common
//

import UIKit

public final class CommonModule: Module {
    /// A concrete type of the class that contains all dependencies required by the receiver to work properly.
    /// - SeeAlso: Module.Setup
    public typealias Setup = CommonModuleSetup

    /// A concrete type of the class that contains the 2way communication interface (to the module and outside of it).
    /// - SeeAlso: Module.Interface
    public typealias Interface = CommonModuleInterface

    /// - SeeAlso: Module.name
    public static var identifier: String {
        "CommonModule"
    }

    /// A weak reference to the interface to communicate outside of the module through the single point of contact.
    private weak var interface: CommonModuleInterface?

    /// Initializes the module with setup class containing all dependencies required by the receiver to work properly.
    /// - Parameter setup: An instance of the setup class.
    init(setup: CommonModuleSetup) {
        // TODO: Setup module with required dependencies given in `CommonModuleSetup`
    }
}

// MARK: Public

public extension CommonModule {
    /// Creates entire module with the setup class.
    /// - Parameter setup: Contains dependencies required by the module to work properly.
    /// - Returns: An interface of the created module.
    class func create(setup: CommonModuleSetup) -> CommonModuleInterface {
        let module = CommonModule(setup: setup)
        let interface = CommonModuleInterface(module: module)
        module.interface = interface
        return interface
    }
}
