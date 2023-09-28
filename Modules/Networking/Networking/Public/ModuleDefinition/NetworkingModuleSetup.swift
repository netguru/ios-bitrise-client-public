//
//  NetworkingModuleSetup.swift
//  Networking
//

import Common

public struct NetworkingModuleSetup: ModuleSetup {
    /// The scheme subcomponent of the URL.
    let scheme: HTTPScheme

    /// The host subcomponent.
    let host: String

    /// App version injected to HTTP headers.
    let version: String

    /// A storage where the authentication token should be stored.
    let credentialsStorage: CredentialsStorage

    public init(scheme: HTTPScheme, host: String, version: String, credentialsStorage: CredentialsStorage) {
        self.scheme = scheme
        self.host = host
        self.version = version
        self.credentialsStorage = credentialsStorage
    }
}
