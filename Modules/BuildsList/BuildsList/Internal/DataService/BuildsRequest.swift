//
//  BuildsRequest.swift
//  BuildsList
//

import Common
import Networking

struct BuildsRequest: ApiRequest {
    typealias Response = BuildsResponse

    var path: String
    var parameters: [String: Any]?
    var method: HTTPMethod = .GET

    init(application: BitriseApplication) {
        path = "apps/\(application.slug)/builds"
    }
}
