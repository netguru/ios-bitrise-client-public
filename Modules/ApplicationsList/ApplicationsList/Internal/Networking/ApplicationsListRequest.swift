//
//  ApplicationsListEndpoint.swift
//  ApplicationsList
//

import Networking

struct ApplicationsListRequest: ApiRequest {

    typealias Response = ApplicationsListResponse

    enum SortBy: String, Decodable {
        case lastBuildAt = "last_build_at"
        case createdAt = "created_at"
    }

    let path = "apps"

    var sortBy: SortBy

    var parameters: [String: Any]? {
        [
            "sort_by": sortBy.rawValue
        ]
    }

    let method: HTTPMethod = .GET
}
