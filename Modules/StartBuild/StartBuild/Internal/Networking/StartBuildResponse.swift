//
//  StartBuildResponse.swift
//  StartBuild
//

import Foundation
import Common

struct StartBuildResponse: Decodable {
    let buildNumber: Int
    let buildSlug: String
    let buildURL: String
    let message: String
    let service: String
    let slug: String
    let status: String
    let workflow: String
}

private extension StartBuildResponse {
    enum CodingKeys: String, CodingKey {
        case buildNumber = "build_number"
        case buildSlug = "build_slug"
        case buildURL = "build_url"
        case message
        case service
        case slug
        case status
        case workflow = "triggered_workflow"
    }
}
