//
//  UserApiRequest.swift
//  BitriseClient
//

import Networking

struct UserApiRequest: ApiRequest {
    typealias Response = UserApiResponse

    var path: String = "me"
    var parameters: [String: Any]?
    var method: HTTPMethod = .GET
}
