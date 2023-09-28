// ___FILEHEADER___

import Common
import UIKit

public final class ___VARIABLE_productName:identifier___Module: Module {
    /// A concrete type of the class that contains all dependencies required by the receiver to work properly.
    /// - SeeAlso: Module.Setup
    public typealias Setup = ___VARIABLE_productName: identifier___ModuleSetup

    /// A concrete type of the class that contains the 2way communication interface (to the module and outside of it).
    /// - SeeAlso: Module.Interface
    public typealias Interface = ___VARIABLE_productName: identifier___ModuleInterface

    /// - SeeAlso: Module.name
    public static var name: String {
        "___VARIABLE_productName:identifier___Module"
    }

    /// A view controller that will be used outside of the integration as an entry point to the module
    /// which should be attached to the app's view hierarchy.
    var rootViewController: UIViewController {
        // TODO: Provide an entry view controller for this module.
        // TODO: Delete this variable if module does not have UI representation.
        <#UIViewController#>
    }

    /// A weak reference to the interface to communicate outside of the module through the single point of contact.
    private weak var interface: ___VARIABLE_productName: identifier___ModuleInterface?

    /// Initializes the module with setup class containing all dependencies required by the receiver to work properly.
    /// - Parameter setup: An instance of the setup class.
    init(setup: ___VARIABLE_productName: identifier___ModuleSetup) {
        // TODO: Setup module with required dependencies given in `___VARIABLE_productName:identifier___ModuleSetup`
    }
}

// MARK: Public

public extension ___VARIABLE_productName: identifier___Module {
    /// Creates entire module with the setup class.
    /// - Parameter setup: Contains dependencies required by the module to work properly.
    /// - Returns: An interface of the created module.
    class func create(setup: ___VARIABLE_productName: identifier___ModuleSetup) -> ___VARIABLE_productName: identifier___ModuleInterface {
        let module = ___VARIABLE_productName: identifier___Module(setup: setup)
        let interface = ___VARIABLE_productName: identifier___ModuleInterface(module: module)
        module.interface = interface
        return interface
    }
}
