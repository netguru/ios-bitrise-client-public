//
//  BuildsListModuleSetup.swift
//  BuildsList
//

import Common
import Networking

public struct BuildsListModuleSetup: ModuleSetup {
    public enum NetworkService {
        case real(Networking.NetworkService)
        case mock

        fileprivate var rawValue: Networking.NetworkService {
            switch self {
            case let .real(networkService):
                return networkService
            case .mock:
                return BuildsListMockNetworkService()
            }
        }
    }

    /// A network service used by the module to make in-module requests.
    let networkService: Networking.NetworkService

    /// An application which details should be displayed.
    let application: BitriseApplication

    public init(application: BitriseApplication, networkService: NetworkService) {
        self.application = application
        self.networkService = networkService.rawValue
    }
}
