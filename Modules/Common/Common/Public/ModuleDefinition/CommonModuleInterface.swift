//
//  CommonModuleInterface.swift
//  Common
//

import UIKit

public final class CommonModuleInterface: ModuleInterface {
    /// A concrete type of the enum that contains all actions that goes outside the module.
    /// - SeeAlso: ModuleInterface.Setup
    public typealias Action = CommonModuleAction

    /// A concrete type of the class which this interface represents.
    /// - SeeAlso: ModuleInterface.AssociatedModule
    public typealias AssociatedModule = CommonModule

    /// An instance of the module class which this interface represents.
    public let module: CommonModule

    /// A closure to assign from the outside of the module to establish 2way communication between the caller and the module.
    public var actionHandler: ((AssociatedModule, Action) -> Void)?

    /// - SeeAlso: ModuleInterface.rootViewController
    public var rootViewController: UIViewController? {
        nil
    }

    /// A storage where the credentials should be stored.
    public let credentialStorage: CredentialsStorage = DefaultCredentialStorage()

    /// A storage where user data should be stored.
    public let userStorage: UserStorage = DefaultUserStorage()

    /// Initializes an interface with the module that the receiver should represent.
    /// - Parameter module: An instance of the module class to represent.
    required init(module: AssociatedModule) {
        self.module = module
    }
}
