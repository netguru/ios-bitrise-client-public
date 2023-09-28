//
//  UserDataService.swift
//  BitriseClient
//

import Common
import Networking

struct UserDataService {
    static func fetchUserAndStore(in store: UserStorage, using networking: NetworkService) {
        networking.sendRequest(request: UserApiRequest()) { result in
            switch result {
            case let .success(response):
                store.storeUser(user: response.data) { _ in }
            case let .failure(error):
                print(error)
            }
        }
    }
}
