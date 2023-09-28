//
//  DefaultNetworkService.swift
//  Networking
//
import Foundation
import Common

struct DefaultNetworkService: NetworkService {
    private let scheme: HTTPScheme

    private let host: String

    private let version: String

    private let credentialsStorage: CredentialsStorage

    init(
        scheme: HTTPScheme,
        host: String,
        version: String,
        credentialsStorage: CredentialsStorage
    ) {
        self.scheme = scheme
        self.host = host
        self.version = version
        self.credentialsStorage = credentialsStorage
    }

    func sendRequest<Request: ApiRequest>(
        request: Request,
        completion: @escaping (Result<Request.Response, ApiError>) -> Void
    ) {
        let urlString = "\(scheme.rawValue)://\(host)/\(version)/\(request.path)"
        guard var components = URLComponents(string: urlString) else {
            completion(.failure(.unknown(message: "can't create url")))
            return
        }
        if request.parametersEncoding == .url {
            components.queryItems = request.parameters?.map {
                URLQueryItem(name: $0.key, value: $0.value as? String)
            }
        }
        guard let url = components.url else {
            completion(.failure(.unknown(message: "can't create url")))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        if request.parametersEncoding == .json, let params = request.parameters {

            let data = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        credentialsStorage.fetchToken { tokenResult in
            switch tokenResult {
            case let .success(token):
                urlRequest.setValue(token, forHTTPHeaderField: "Authorization")
                sendRequest(request: request, urlRequest: urlRequest, completion: completion)
            case let .failure(error):
                completion(.failure(.unknown(message: error.localizedDescription)))
            }
        }
    }

    func sendRequest<Request: ApiRequest>(
        request: Request,
        urlRequest: URLRequest,
        completion: @escaping (Result<Request.Response, ApiError>) -> Void
    ) {
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let error = error {
                completion(.failure(.serverError(error)))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let object = try decoder.decode(Request.Response.self, from: data)
                    completion(.success(object))
                } catch {
                    if Request.Response.self == String.self,
                       let string = String(data: data, encoding: .utf8),
                       let result = string as? Request.Response {

                        completion(.success(result))
                    } else {
                        completion(.failure(.decodingError(error)))
                    }
                }
            }
        }.resume()
    }
}
