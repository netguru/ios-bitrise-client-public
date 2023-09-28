//
//  BitriseBuildStatus.swift
//  Common
//

public enum BitriseBuildStatus: Int, Decodable {
    case notFinished = 0
    case success = 1
    case error = 2
    case unknown = -1
    case abortedWithError = 3
    case abortedWithSuccess = 4
}
