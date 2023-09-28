//
//  AppModules.swift
//  BitriseClient
//

import Common
import CommonUI
import Networking
import UIKit

import ApplicationsList
import ApplicationDetails
import BitriseAuthentication
import BuildsList
import GeneralScreens
import StartBuild

final class AppModules {

    // MARK: Properties

    private let modules = ModulesContainer()

    // MARK: Common Modules

    /// A common `Common` module which is used by other modules is always stored in the memory.
    /// Contains shared elements.
    lazy var common = modules.create(
        module: CommonModule.self,
        setup: CommonModuleSetup()
    )

    /// A common `CommonUI` module which is used by other modules is always stored in the memory.
    /// Contains shared UI elements.
    lazy var commonUI = modules.create(
        module: CommonUIModule.self,
        setup: CommonUIModuleSetup()
    )

    /// A common `Networking` module which is used by other modules is always stored in the memory.
    /// Contains networking layer elements.
    lazy var networking = modules.create(
        module: NetworkingModule.self,
        setup: NetworkingModuleSetup(
            scheme: .https,
            host: "api.bitrise.io",
            version: "v0.1",
            credentialsStorage: common.credentialStorage
        )
    )

    // MARK: Domain Modules

    /// Creates an `ApplicationsListModule` on demand.
    /// If already created, returns the currently stored instance.
    func applicationsList() -> ApplicationsListModuleInterface {
        modules.create(
            module: ApplicationsListModule.self,
            setup: ApplicationsListModuleSetup(networkService: .real(networking.service))
        )
    }

    /// Creates an `ApplicationDetailsModule` on demand.
    /// If already created, returns the currently stored instance.
    /// - Parameter application: An application which details should be displayed.
    func applicationDetails(_ application: BitriseApplication) -> ApplicationDetailsModuleInterface {
        let buildsController = buildsList(application).rootViewController ?? UIViewController()
        let startBuildController = startBuild(application).rootViewController ?? UIViewController()
        return modules.create(
            module: ApplicationDetailsModule.self,
            setup: ApplicationDetailsModuleSetup(
                application: application,
                networkService: .real(networking.service),
                buildsViewController: buildsController,
                startBuildViewController: startBuildController
            )
        )
    }

    /// Creates an `BitriseAuthenticationModule` on demand.
    /// If already created, returns the currently stored instance.
    func bitriseAuthentication() -> BitriseAuthenticationModuleInterface {
        modules.create(
            module: BitriseAuthenticationModule.self,
            setup: BitriseAuthenticationModuleSetup()
        )
    }

    /// Creates an `BuildsListModule` on demand.
    /// If already created, returns the currently stored instance.
    /// - Parameter application: An application which builds list should be displayed.
    func buildsList(_ application: BitriseApplication) -> BuildsListModuleInterface {
        modules.create(
            module: BuildsListModule.self,
            setup: BuildsListModuleSetup(
                application: application,
                networkService: .real(networking.service)
            )
        )
    }

    /// Creates an `GeneralScreensModule` on demand.
    /// If already created, returns the currently stored instance.
    func generalScreens() -> GeneralScreensModuleInterface {
        modules.create(
            module: GeneralScreensModule.self,
            setup: GeneralScreensModuleSetup(
                credentialsStorage: common.credentialStorage,
                userStorage: common.userStorage
            )
        )
    }

    /// Creates an `StartBuildModule` on demand.
    /// If already created, returns the currently stored instance.
    func startBuild(_ application: BitriseApplication) -> StartBuildModuleInterface {
        modules.create(
            module: StartBuildModule.self,
            setup: StartBuildModuleSetup(
                networkService: .real(networking.service),
                application: application
            )
        )
    }

    /// Release a module of given type from the memory.
    /// - Parameter module: A module to deinitialize.
    func release<T: Module>(module: T.Type) {
        modules.release(module: module)
    }
}
