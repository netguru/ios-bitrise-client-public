//
//  GeneralScreensModuleSetup.swift
//  GeneralScreens
//

import Common

public struct GeneralScreensModuleSetup: ModuleSetup {
    let credentialsStorage: CredentialsStorage
    let userStorage: UserStorage

    public init(credentialsStorage: CredentialsStorage, userStorage: UserStorage) {
        self.credentialsStorage = credentialsStorage
        self.userStorage = userStorage
    }
}
