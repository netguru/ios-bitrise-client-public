//
//  AppFlowController.swift
//  BitriseClient
//

import Common
import UIKit
import ApplicationsList
import GeneralScreens
import BitriseAuthentication

final class AppFlowController: FlowController {

    let rootViewController: UIViewController = UINavigationController()

    // MARK: Private

    internal var navigationController: UINavigationController? {
        rootViewController as? UINavigationController
    }

    internal let modules = AppModules()

    // MARK: Initializer

    init() {
        setupGeneralScreensActionHandler()
        modules.common.credentialStorage.fetchToken { result in
            switch result {
            case .failure:
                navigationController?.viewControllers = [initialAppViewController()]
            case .success:
                presentApplicationsListScreen()
            }
        }
    }
}

extension AppFlowController {

    func presentEnterTokenScreen() {
        navigationController?.pushViewController(modules.generalScreens().enterTokenViewController, animated: true)
    }

    func presentApplicationsListScreen() {
        applicationsListViewController().flatMap {
            navigationController?.viewControllers = [$0]
        }
    }
}
