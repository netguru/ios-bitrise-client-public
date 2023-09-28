//
//  BitriseUser.swift
//  Common
//

public struct BitriseUser: Codable {
    public let avatarUrl: String
    public let email: String
    public let slug: String
    public let username: String

    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
        case email
        case slug
        case username
    }
}
