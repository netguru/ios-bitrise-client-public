//
//  ApplicationDetailsMockNetworkService.swift
//  ApplicationDetails
//

import Networking
import Common

struct ApplicationDetailsMockNetworkService: NetworkService {
    func sendRequest<Request>(
        request: Request,
        completion: (Result<Request.Response, ApiError>) -> Void
    ) where Request: ApiRequest {
        completion(.failure(.unknown(message: "Unknown mock for request \(Request.self)")))
    }
}
