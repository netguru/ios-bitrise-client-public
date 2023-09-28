//
//  ModulesContainer.swift
//  BitriseClient
//

import ApplicationDetails
import ApplicationsList
import BitriseAuthentication
import BuildsList
import Common
import CommonUI
import GeneralScreens
import Networking
import StartBuild

final class ModulesContainer {
    private var inMemoryModuleInterfaces: [String: Any] = [:]

    /// A constructor of the receiver.
    public init() {
        checkIntegration()
    }

    /// Creates a module with given setup.
    /// - Warning: If module is already initialized then returns its instance instead of creating the new one.
    /// - Parameters:
    ///   - module: A module type to initialize.
    ///   - setup: A setup which will be used to initialize the module.
    /// - Returns: The interface of the module which should be used as a communication bridge.
    @discardableResult
    func create<T: Module>(module: T.Type, setup: T.Setup) -> T.Interface {
        if let current = interface(for: module) {
            return current
        }
        let interface = module.create(setup: setup)
        inMemoryModuleInterfaces[module.identifier] = interface
        return interface
    }

    /// Returns the interface of the module.
    /// - Parameter module: A module which interface should be returned.
    /// - Returns: The instance of interface or `nil` if module wasn't initialized previously.
    func interface<T: Module>(for module: T.Type) -> T.Interface? {
        inMemoryModuleInterfaces[module.identifier] as? T.Interface
    }

    /// Attempts to deinitialize the module.
    /// - Warning: Does nothing if module wasn't initialized previously.
    /// - Parameter module: A module type to deinitialize.
    func release<T: Module>(module: T.Type) {
        inMemoryModuleInterfaces[module.identifier] = nil
    }
}

// MARK: Private

private extension ModulesContainer {
    func checkIntegration() {
        let modules: [ModuleIdentifiable.Type] = [
            ApplicationDetailsModule.self,
            ApplicationsListModule.self,
            BitriseAuthenticationModule.self,
            BuildsListModule.self,
            CommonUIModule.self,
            CommonModule.self,
            GeneralScreensModule.self,
            NetworkingModule.self,
            StartBuildModule.self
        ]

        modules.forEach {
            print("✅ Successfully attached \($0.identifier).")
        }
    }
}
