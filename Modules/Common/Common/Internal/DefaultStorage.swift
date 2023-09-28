//
//  DefaultStorage.swift
//  Common
//
import Foundation

/// Storage implementation that uses UserDefaults.
final class DefaultStorage: Storage {

    private let defaults: UserDefaults

    init(defaults: UserDefaults) {
        self.defaults = defaults
    }

    convenience init() {
        self.init(defaults: .standard)
    }

    func item<T>(of type: T.Type, for key: String, completion: (Result<T, StorageError>) -> Void) {
        if let object = defaults.object(forKey: key) {
            if let object = object as? T {
                completion(.success(object))
            } else {
                completion(.failure(.fetchTypeMismatch))
            }
        } else {
            completion(.failure(.itemDoesNotExist))
        }
    }

    func storeItem<T>(_ item: T, for key: String, completion: (Result<Void, StorageError>) -> Void) {
        defaults.set(item, forKey: key)
        completion(.success(()))
    }

    func removeItem(for key: String, completion: (Result<Void, StorageError>) -> Void) {
        defaults.removeObject(forKey: key)
        completion(.success(()))
    }
}
