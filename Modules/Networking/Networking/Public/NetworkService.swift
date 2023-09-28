//
//  NetworkService.swift
//  Networking
//

/// Definition of protocol for performing Network calls.
public protocol NetworkService {
    func sendRequest<Request: ApiRequest>(
        request: Request,
        completion: @escaping (Result<Request.Response, ApiError>) -> Void
    )
}
