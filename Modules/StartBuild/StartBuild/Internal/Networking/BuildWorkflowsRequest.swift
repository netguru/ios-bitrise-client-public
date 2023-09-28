//
//  BuildWorkflowsRequest.swift
//  StartBuild
//

import Networking

struct BuildWorkflowsRequest: ApiRequest {

    typealias Response = BuildWorkflowsResponse

    var path: String { "apps/\(appSlug)/build-workflows" }

    let appSlug: String

    var parameters: [String: Any]? { nil }

    let method: HTTPMethod = .GET
}
