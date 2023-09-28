//
//  StartBuildModuleSetup.swift
//  StartBuild
//

import Common
import Networking

public struct StartBuildModuleSetup: ModuleSetup {
    public enum NetworkService {
        case real(Networking.NetworkService)
        case mock

        fileprivate var rawValue: Networking.NetworkService {
            switch self {
            case let .real(networkService):
                return networkService
            case .mock:
                return StartBuildMockNetworkService()
            }
        }
    }

    let networkService: Networking.NetworkService
    let application: BitriseApplication
    public init(
        networkService: NetworkService,
        application: BitriseApplication
    ) {
        self.networkService = networkService.rawValue
        self.application = application
    }
}
