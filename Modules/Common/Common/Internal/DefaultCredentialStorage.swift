//
//  DefaultCredentialStorage.swift
//  Common
//

struct DefaultCredentialStorage: CredentialsStorage {
    private static let tokenKey = "CredentialStorage.tokenKey"

    private let storage: Storage

    init() {
        self.init(storage: DefaultStorage())
    }

    init(storage: Storage) {
        self.storage = storage
    }

    func storeToken(token: String, _ completion: (Result<Void, CredentialStorageError>) -> Void) {
        storage.storeItem(token, for: Self.tokenKey) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure:
                completion(.failure(.couldNotStore))
            }
        }
    }

    func fetchToken(_ completion: (Result<String, CredentialStorageError>) -> Void) {
        storage.item(of: String.self, for: Self.tokenKey) { result in
            switch result {
            case let .success(token):
                completion(.success(token))
            case let .failure(error):
                switch error {
                case .itemDoesNotExist:
                    completion(.failure(.tokenNotFound))
                default:
                    completion(.failure(.couldNotFetch))
                }
            }
        }
    }

    func removeToken(_ completion: (Result<Void, CredentialStorageError>) -> Void) {
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
