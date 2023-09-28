//
//  AppFlowController+ApplicationsList.swift
//  BitriseClient
//

import ApplicationsList
import ApplicationDetails
import UIKit

extension AppFlowController {

    func applicationsListViewController() -> UIViewController? {
        let interface = modules.applicationsList()
        interface.actionHandler = { [weak self] module, action in
            self?.applicationsList(module: module, didPerformAction: action)
        }
        return interface.rootViewController
    }

    func applicationsList(
        module: ApplicationsListModule,
        didPerformAction action: ApplicationsListModuleAction
    ) {
        switch action {
        case let .selected(application):
            applicationDetailsViewController(for: application).flatMap {
                navigationController?.pushViewController($0, animated: true)
            }
        case .avatarTapped:
            navigationController?.pushViewController(
                modules.generalScreens().accountViewController,
                animated: true
            )

            return
        }
    }
}
