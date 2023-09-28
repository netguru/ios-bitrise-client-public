//
//  AppFlowController+BuildsList.swift
//  BitriseClient
//

import BuildsList
import Common
import UIKit

extension AppFlowController {

    func buildsListViewController(for application: BitriseApplication) -> UIViewController? {
        let interface = modules.buildsList(application)
        return interface.rootViewController
    }
}
