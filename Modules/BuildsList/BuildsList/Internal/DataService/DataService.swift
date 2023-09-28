//
//  DataService.swift
//  BuildsList
//

import Common
import Networking

enum DataServiceError: Error {
    case apiError(error: Error)
}

protocol DataService {
    var networkService: NetworkService { get }

    func provideBuilds(
        for application: BitriseApplication,
        completion: @escaping (Result<[BitriseAppBuild], DataServiceError>) -> Void
    )
}
