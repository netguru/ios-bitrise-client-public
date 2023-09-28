//
//  BuildsResponse.swift
//  BuildsList
//

import Common
import Foundation

struct BuildsResponse: Decodable {
    let data: [BitriseAppBuild]
}
