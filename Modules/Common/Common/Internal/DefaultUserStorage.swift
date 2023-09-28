//
//  DefaultUserStorage.swift
//  Common
//

import Foundation

struct DefaultUserStorage: UserStorage {
    private static let tokenKey = "UserStorage.tokenKey"

    private let storage: Storage

    init() {
        self.init(storage: DefaultStorage())
    }

    init(storage: Storage) {
        self.storage = storage
    }

    func storeUser(user: BitriseUser, _ completion: (Result<Void, UserStorageError>) -> Void) {
        guard let userData = try? JSONEncoder().encode(user) else {
            completion(.failure(.couldNotStore))
            return
        }
        let jsonString = String(data: userData, encoding: .utf8)
        storage.storeItem(jsonString, for: Self.tokenKey) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure:
                completion(.failure(.couldNotStore))
            }
        }
    }

    func fetchUser(_ completion: (Result<BitriseUser, UserStorageError>) -> Void) {
        storage.item(of: String.self, for: Self.tokenKey) { result in
            switch result {
            case let .success(string):
                if let data = string.data(using: .utf8),
                   let user = try? JSONDecoder().decode(BitriseUser.self, from: data) {
                    completion(.success(user))
                } else {
                    completion(.failure(.couldNotFetch))
                }
            case let .failure(error):
                switch error {
                case .itemDoesNotExist:
                    completion(.failure(.userNotFound))
                default:
                    completion(.failure(.couldNotFetch))
                }
            }
        }
    }

    func removeUser(_ completion: (Result<Void, CredentialStorageError>) -> Void) {
        storage.removeItem(for: Self.tokenKey) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure:
                completion(.failure(.couldNotRemove))
            }
        }
    }
}
