//
//  ApplicationDetailsModuleSetup.swift
//  ApplicationDetails
//

import Common
import Networking
import UIKit

public struct ApplicationDetailsModuleSetup: ModuleSetup {
    public enum NetworkService {
        case real(Networking.NetworkService)
        case mock

        fileprivate var rawValue: Networking.NetworkService {
            switch self {
            case let .real(networkService):
                return networkService
            case .mock:
                return ApplicationDetailsMockNetworkService()
            }
        }
    }

    /// A network service used by the module to make in-module requests.
    let networkService: Networking.NetworkService

    /// An application which details should be displayed.
    let application: BitriseApplication

    /// View controller displaying list of application builds
    let buildsViewController: UIViewController

    /// View controller displaying allowing to start a new build
    let startBuildViewController: UIViewController

    public init(
        application: BitriseApplication,
        networkService: NetworkService,
        buildsViewController: UIViewController,
        startBuildViewController: UIViewController
    ) {
        self.application = application
        self.networkService = networkService.rawValue
        self.buildsViewController = buildsViewController
        self.startBuildViewController = startBuildViewController
    }
}
