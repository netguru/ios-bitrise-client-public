//
//  ApplicationsListResponse.swift
//  ApplicationsList
//

import Foundation
import Common

struct ApplicationsListResponse: Decodable {
    let applications: [BitriseApplication]
}

private extension ApplicationsListResponse {
    enum CodingKeys: String, CodingKey {
        case applications = "data"
    }
}
