//
//  YMLDownloadRequest.swift
//  ApplicationDetails
//

import Networking

struct YMLDownloadRequest: ApiRequest {

    typealias Response = String

    var path: String { "apps/\(appSlug)/bitrise.yml" }

    let appSlug: String

    var parameters: [String: Any]? { nil }

    let method: HTTPMethod = .GET
}
