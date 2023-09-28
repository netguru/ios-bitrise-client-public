//
//  NetworkingModule.swift
//  Networking
//

import Common
import UIKit

public final class NetworkingModule: Module {
    /// A concrete type of the class that contains all dependencies required by the receiver to work properly.
    /// - SeeAlso: Module.Setup
    public typealias Setup = NetworkingModuleSetup

    /// A concrete type of the class that contains the 2way communication interface (to the module and outside of it).
    /// - SeeAlso: Module.Interface
    public typealias Interface = NetworkingModuleInterface

    /// - SeeAlso: Module.name
    public static var identifier: String {
        "NetworkingModule"
    }

    /// A weak reference to the interface to communicate outside of the module through the single point of contact.
    private weak var interface: NetworkingModuleInterface?

    /// A default service for this module.
    let service: DefaultNetworkService

    /// Initializes the module with setup class containing all dependencies required by the receiver to work properly.
    /// - Parameter setup: An instance of the setup class.
    init(setup: NetworkingModuleSetup) {
        service = DefaultNetworkService(
            scheme: setup.scheme,
            host: setup.host,
            version: setup.version,
            credentialsStorage: setup.credentialsStorage
        )
    }
}

// MARK: Public

public extension NetworkingModule {
    /// Creates entire module with the setup class.
    /// - Parameter setup: Contains dependencies required by the module to work properly.
    /// - Returns: An interface of the created module.
    class func create(setup: NetworkingModuleSetup) -> NetworkingModuleInterface {
        let module = NetworkingModule(setup: setup)
        let interface = NetworkingModuleInterface(module: module)
        module.interface = interface
        return interface
    }
}
