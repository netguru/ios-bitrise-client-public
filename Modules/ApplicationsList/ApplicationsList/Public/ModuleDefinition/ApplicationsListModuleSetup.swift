//
//  ApplicationsListSetup.swift
//  ApplicationsList
//

import Common
import Networking

public struct ApplicationsListModuleSetup: ModuleSetup {
    public enum NetworkService {
        case real(Networking.NetworkService)
        case mock

        fileprivate var rawValue: Networking.NetworkService {
            switch self {
            case let .real(networkService):
                return networkService
            case .mock:
                return ApplicationsListMockNetworkService()
            }
        }
    }

    /// A network service used by the module to make in-module requests.
    let networkService: Networking.NetworkService

    public init(networkService: NetworkService) {
        self.networkService = networkService.rawValue
    }
}
