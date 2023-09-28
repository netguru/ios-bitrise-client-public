//
//  CredentialStorage.swift
//  Common
//

public enum CredentialStorageError: Error {
    case couldNotFetch
    case couldNotStore
    case tokenNotFound
    case couldNotRemove
}

public protocol CredentialsStorage {
    func storeToken(token: String, _ completion: (Result<Void, CredentialStorageError>) -> Void)
    func fetchToken(_ completion: (Result<String, CredentialStorageError>) -> Void)
    func removeToken(_ completion: (Result<Void, CredentialStorageError>) -> Void)
}
