//
//  BuildWorkflowsResponse.swift
//  StartBuild
//

import Foundation
import Common

struct BuildWorkflowsResponse: Decodable {
    let workflows: [String]
}

private extension BuildWorkflowsResponse {
    enum CodingKeys: String, CodingKey {
        case workflows = "data"
    }
}
