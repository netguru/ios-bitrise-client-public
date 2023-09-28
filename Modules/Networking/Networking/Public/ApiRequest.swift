//
//  ApiRequest.swift
//  Networking
//

/// Api Request interface
public protocol ApiRequest {

    /// A type of  a response, that request's  raw (data) response should be parsed to. Must adopt `Decodable` protocol.
    associatedtype Response: Decodable

    /// The relative path.
    var path: String { get }

    /// Parameters to inject as request's body or query.
    var parameters: [String: Any]? { get }

    /// HTTP method as specified by the server.
    var method: HTTPMethod { get }

    /// Controls how parameters are encoded in the request.
    /// `.url` is default.
    var parametersEncoding: ParametersEncoding { get }
}

public extension ApiRequest {
    var parametersEncoding: ParametersEncoding {
        .url
    }
}
