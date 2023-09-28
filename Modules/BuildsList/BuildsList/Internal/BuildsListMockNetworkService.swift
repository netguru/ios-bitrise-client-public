//
//  BuildsListMockNetworkService.swift
//  BuildsList
//

import Common
import Foundation
import Networking

struct BuildsListMockNetworkService: NetworkService {
    func sendRequest<Request>(
        request: Request,
        completion: (Result<Request.Response, ApiError>) -> Void
    ) where Request: ApiRequest {
        let response = BuildsResponse(data: [
            BitriseAppBuild(
                triggeredAt: Date().addingTimeInterval(-120),
                startedOnWorkerAt: Date().addingTimeInterval(-60),
                finishedAt: Date(),
                slug: "asd",
                status: .notFinished,
                branch: "develop",
                buildNumber: 23,
                triggeredWorkflow: "pull_request",
                commitMessage: "Feels good"
            ),
            BitriseAppBuild(
                triggeredAt: Date().addingTimeInterval(-250),
                startedOnWorkerAt: Date().addingTimeInterval(-200),
                finishedAt: Date(),
                slug: "asd",
                status: .error,
                branch: "develop",
                buildNumber: 23,
                triggeredWorkflow: "pull_request",
                commitMessage: "Feels good"
            ),
            BitriseAppBuild(
                triggeredAt: Date().addingTimeInterval(-500),
                startedOnWorkerAt: Date().addingTimeInterval(-460),
                finishedAt: Date(),
                slug: "asd",
                status: .success,
                branch: "develop",
                buildNumber: 23,
                triggeredWorkflow: "pull_request",
                commitMessage: "Feels good"
            )
        ]) as? Request.Response

        if let supportedMockedResponse = response {
            completion(.success(supportedMockedResponse))
        } else {
            completion(.failure(.unknown(message: "Unknown mock for request \(Request.self)")))
        }
    }
}
