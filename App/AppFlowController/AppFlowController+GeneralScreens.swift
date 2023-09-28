//
//  AppFlowController+GeneraScreens.swift
//  BitriseClient
//

import GeneralScreens
import UIKit

extension AppFlowController {
    func initialAppViewController() -> UIViewController {
        let interface = modules.generalScreens()
        let viewController = interface.appInitialViewController
        return viewController
    }

    func setupGeneralScreensActionHandler() {
        let interface = modules.generalScreens()
        interface.actionHandler = { [weak self] module, action in
            self?.generalScreens(module: module, didPerformAction: action)
        }
    }

    func generalScreens(
        module: GeneralScreensModule,
        didPerformAction action: GeneralScreensModuleAction
    ) {
        switch action {
        case .enterTokenSelected:
            presentEnterTokenScreen()
        case .tokenSaved:
            presentApplicationsListScreen()
            UserDataService.fetchUserAndStore(
                in: modules.common.userStorage,
                using: modules.networking.service
            )
        case .createTokenSelected:
            bitriseAuthenticationController().flatMap {
                navigationController?.pushViewController($0, animated: true)
            }
            return
        case .logoutSelected:
            modules.common.credentialStorage.removeToken { _ in }
            modules.common.userStorage.removeUser { _ in }
            navigationController?.viewControllers = [modules.generalScreens().appInitialViewController]
        }
    }
}
