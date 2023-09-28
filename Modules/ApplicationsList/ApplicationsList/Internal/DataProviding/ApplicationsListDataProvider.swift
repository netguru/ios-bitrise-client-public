//
//  ApplicationsListDataProvider.swift
//  ApplicationsList
//

import Networking
import Common

enum ApplicationsListDataProviderError: Error {
    case api(error: ApiError)
}

final class ApplicationsListDataProvider {

    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

extension ApplicationsListDataProvider {
    func fetchApplications(
        completion: @escaping (Result<[BitriseApplication], ApplicationsListDataProviderError>) -> Void
    ) {
        let request = ApplicationsListRequest(sortBy: .lastBuildAt)
        networkService.sendRequest(request: request) { result in
            switch result {
            case let .failure(error):
                completion(.failure(ApplicationsListDataProviderError.api(error: error)))
            case let .success(response):
                // applications that have not finished the setup process are also
                // returned in the response but are missing projectType,
                // we do not want to sho them on the list.
                // We also filter out disabled applications.
                let applications = response.applications.filter { $0.projectType != nil && !$0.isDisabled }
                completion(.success(applications))
            }
        }
    }
}
