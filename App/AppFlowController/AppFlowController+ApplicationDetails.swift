//
//  AppFlowController+ApplicationDetails.swift
//  BitriseClient
//

import ApplicationDetails
import BuildsList
import Common
import StartBuild
import UIKit

extension AppFlowController {

    func applicationDetailsViewController(for application: BitriseApplication) -> UIViewController? {
        let interface = modules.applicationDetails(application)
        interface.rootViewController?.title = application.title
        interface.actionHandler = { [weak self] module, action in
            self?.applicationDetails(module: module, didPerformAction: action)
        }
        return interface.rootViewController
    }

    func applicationDetails(
        module: ApplicationDetailsModule,
        didPerformAction action: ApplicationDetailsModuleAction
    ) {
        switch action {
        case .moduleViewDismissed:
            modules.release(module: ApplicationDetailsModule.self)
            modules.release(module: BuildsListModule.self)
            modules.release(module: StartBuildModule.self)
        }
    }
}
