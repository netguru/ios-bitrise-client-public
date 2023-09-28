//
//  ApiError.swift
//  Networking
//

public enum ApiError: Error {
    case offline
    case timeout
    case cancelled
    case serverError(_ error: Error)
    case decodingError(_ error: Error)
    case unknown(message: String)
}
