//
//  DefaultDataService.swift
//  BuildsList
//

import Common
import Networking

struct DefaultDataService: DataService {

    var networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func provideBuilds(
        for application: BitriseApplication,
        completion: @escaping (Result<[BitriseAppBuild], DataServiceError>) -> Void
    ) {
        networkService.sendRequest(request: BuildsRequest(application: application)) { result in
            switch result {
            case let .success(data):
                completion(.success(data.data))
            case let .failure(error):
                completion(.failure(.apiError(error: error)))
            }
        }
    }
}
