//
//  Module.swift
//  Common
//

import UIKit

/// This is temporary protocol to adopt by all modules which are not yet migrated to `Module` protocol requirements.
public protocol ModuleIdentifiable {
    /// A module identifier.
    static var identifier: String { get }
}

/// A protocol to adopt by any module added to this project.
public protocol Module: ModuleIdentifiable {
    /// A placeholder of a struct/class type responsible for setting up the module,
    /// to use until the `ModuleSetup` is adopted and the exact type is specified.
    associatedtype Setup: ModuleSetup

    /// A placeholder of a struct/class type responsible for exposing a common interface of the module,
    /// to use until the `ModuleInterface` is adopted and the exact type is specified.
    associatedtype Interface: ModuleInterface

    /// Required initializer allowing to setup the integration correctly.
    /// - Parameters:
    ///   - setup: A placeholder that contains all requirements  to setup the module correctly.
    /// - Returns: A placeholder that contains the public interface of the module,
    ///            which is the API exposed outside of the module, ready to consume.
    static func create(setup: Setup) -> Interface
}

/// The protocol to adopt by a class/struct/enum that will be used
/// as an exact type (`typealias`) of the `associatedtype`.
public protocol ModuleSetup {}

/// The protocol to adopt by a class/struct/enum that will be used
/// as an exact type (`typealias`) of the `associatedtype`.
public protocol ModuleInterface {
    /// A placeholder of a struct/class type responsible for exposing actions/events that cannot be handled
    /// from within the integration, like e.g. changing authorisation status.
    associatedtype Action: ModuleAction

    /// A placeholder of a module struct/class type which the interface represents.
    associatedtype AssociatedModule: Module

    /// A view controller that will be used outside of the integration as an entry point to the module
    /// which should be attached to the app's view hierarchy.
    /// - Warning: Might be nil for modules which does not have UI representation.
    var rootViewController: UIViewController? { get }

    /// A handler that will be invoked to inform the receiver that the action could not be handled
    /// inside the module and it is required to handle the action outside of it.
    /// Contains 2 arguments:
    /// - `AssociatedModule`: A module from within the action has been dispatched.
    /// - `Action`: A dispatched action by a module.
    var actionHandler: ((AssociatedModule, Action) -> Void)? { get }
}

/// The protocol to adopt by a class/struct/enum that will be used
/// as an exact type (`typealias`) of the `associatedtype`.
public protocol ModuleAction {}
