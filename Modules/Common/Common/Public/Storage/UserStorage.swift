//
//  UserStorage.swift
//  Common
//

import Foundation

public enum UserStorageError: Error {
    case couldNotFetch
    case couldNotStore
    case userNotFound
    case couldNotRemove
}

public protocol UserStorage {
    func storeUser(user: BitriseUser, _ completion: (Result<Void, UserStorageError>) -> Void)
    func fetchUser(_ completion: (Result<BitriseUser, UserStorageError>) -> Void)
    func removeUser(_ completion: (Result<Void, CredentialStorageError>) -> Void)
}
