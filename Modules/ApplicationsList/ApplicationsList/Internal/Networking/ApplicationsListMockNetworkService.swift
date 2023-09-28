//
//  ApplicationsListMockNetworkService.swift
//  ApplicationsList
//

import Networking
import Common

struct ApplicationsListMockNetworkService: NetworkService {
    func sendRequest<Request>(
        request: Request,
        completion: (Result<Request.Response, ApiError>) -> Void
    ) where Request: ApiRequest {
        let response = ApplicationsListResponse(applications: [
            BitriseApplication(
                slug: "fixture.slug",
                title: "fixture.title",
                projectType: .iOS,
                isDisabled: false,
                buildStatus: .success,
                repoUrl: "fixture.repo.url"
            )
        ]) as? Request.Response

        if let supportedMockedResponse = response {
            completion(.success(supportedMockedResponse))
        } else {
            completion(.failure(.unknown(message: "Unknown mock for request \(Request.self)")))
        }
    }
}
