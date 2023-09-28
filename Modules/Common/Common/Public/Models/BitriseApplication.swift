//
//  BitriseApplication.swift
//  Common
//

public struct BitriseApplication: Decodable {
    public let slug: String
    public let title: String
    public let projectType: BitriseProjectType?
    public let isDisabled: Bool
    public let buildStatus: BitriseBuildStatus
    public let repoUrl: String

    public init(
        slug: String,
        title: String,
        projectType: BitriseProjectType?,
        isDisabled: Bool,
        buildStatus: BitriseBuildStatus,
        repoUrl: String
    ) {
        self.slug = slug
        self.title = title
        self.projectType = projectType
        self.isDisabled = isDisabled
        self.buildStatus = buildStatus
        self.repoUrl = repoUrl
    }
}

private extension BitriseApplication {
    enum CodingKeys: String, CodingKey {
        case slug
        case title
        case projectType = "project_type"
        case isDisabled = "is_disabled"
        case buildStatus = "status"
        case repoUrl = "repo_url"
    }
}
