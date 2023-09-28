//
//  Storage.swift
//  Common
//

/// Describes possible errors related to storage.
public enum StorageError: Error {
    case itemDoesNotExist
    case fetchTypeMismatch
}

/// Storage protocol used for storing Any type of objects.
public protocol Storage {

    /// Fetches the item of desired type from the storage.
    /// - Parameters:
    ///   - type: Type of the object to fetch.
    ///   - key: Key used for storing the item.
    ///   - completion: Result object, providing object or error information.
    func item<T: Any>(of type: T.Type, for key: String, completion: (Result<T, StorageError>) -> Void)

    /// Stores the item of desired in the storage.
    /// - Parameters:
    ///   - key: Key used for storing the item.
    ///   - completion: Result object, providing object or error information.
    func storeItem<T: Any>(_ item: T, for key: String, completion: (Result<Void, StorageError>) -> Void)

    /// Removes item referenced by passed key from storage.
    /// - Parameters:
    ///   - key: Key of item to remove
    ///   - completion: Completion block called on operation finish
    func removeItem(for key: String, completion: (Result<Void, StorageError>) -> Void)
}
