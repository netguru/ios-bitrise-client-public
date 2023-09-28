//
//  BitriseAppBuild.swift
//  Common
//

import Foundation

public struct BitriseAppBuild: Decodable {

    public let triggeredAt: Date
    public let startedOnWorkerAt: Date?
    public let finishedAt: Date?
    public let slug: String
    public let status: BitriseBuildStatus
    public let branch: String
    public let buildNumber: Int
    public let triggeredWorkflow: String
    public let commitMessage: String?

    public init(
        triggeredAt: Date,
        startedOnWorkerAt: Date?,
        finishedAt: Date?,
        slug: String,
        status: BitriseBuildStatus,
        branch: String,
        buildNumber: Int,
        triggeredWorkflow: String,
        commitMessage: String?
    ) {
        self.triggeredAt = triggeredAt
        self.startedOnWorkerAt = startedOnWorkerAt
        self.finishedAt = finishedAt
        self.slug = slug
        self.status = status
        self.branch = branch
        self.buildNumber = buildNumber
        self.triggeredWorkflow = triggeredWorkflow
        self.commitMessage = commitMessage
    }
}

private extension BitriseAppBuild {
    enum CodingKeys: String, CodingKey {
        case triggeredAt = "triggered_at"
        case startedOnWorkerAt = "started_on_worker_at"
        case finishedAt = "finished_at"
        case slug
        case status
        case branch
        case buildNumber = "build_number"
        case triggeredWorkflow = "triggered_workflow"
        case commitMessage = "commit_message"
    }
}
