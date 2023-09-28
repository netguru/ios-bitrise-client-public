//
//  StartBuildRequest.swift
//  StartBuild
//

import Networking

struct StartBuildRequest: ApiRequest {

    typealias Response = StartBuildResponse

    var path: String { "apps/\(appSlug)/builds" }

    let appSlug: String

    let branch: String

    let workflow: String

    var parameters: [String: Any]? {
        [
            "build_params": [
                "branch": branch,
                "workflow_id": workflow
            ],
            "hook_info": [
                "type": "bitrise"
            ]
        ]
    }

    let method: HTTPMethod = .POST

    var parametersEncoding: ParametersEncoding = .json
}
