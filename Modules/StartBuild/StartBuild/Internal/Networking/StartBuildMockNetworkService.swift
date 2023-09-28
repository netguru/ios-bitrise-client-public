//
//  StartBuildMockNetworkService.swift
//  StartBuild
//

import Networking
import Common

struct StartBuildMockNetworkService: NetworkService {
    func sendRequest<Request>(
        request: Request,
        completion: (Result<Request.Response, ApiError>) -> Void
    ) where Request: ApiRequest {
        let response: Request.Response? = {
            switch request {
            case is BuildWorkflowsRequest:
                return BuildWorkflowsResponse(workflows: ["pr", "prod", "nightly"]) as? Request.Response
            case is StartBuildRequest:
                return StartBuildResponse(
                    buildNumber: 2137,
                    buildSlug: "qwerty",
                    buildURL: "https://google.com",
                    message: "Good job",
                    service: "nice",
                    slug: "asdf",
                    status: "NOICE!",
                    workflow: (request as? StartBuildRequest)?.workflow ?? "workflow"
                ) as? Request.Response
            default: return nil
            }
        }()

        if let supportedMockedResponse = response {
            completion(.success(supportedMockedResponse))
        } else {
            completion(.failure(.unknown(message: "Unknown mock for request \(Request.self)")))
        }
    }
}
