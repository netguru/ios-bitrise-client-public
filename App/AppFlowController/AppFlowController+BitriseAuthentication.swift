//
//  AppFlowController+BitriseAuthentication.swift
//  BitriseClient
//

import BitriseAuthentication
import UIKit

extension AppFlowController {
    func bitriseAuthenticationController() -> UIViewController? {
        let interface = modules.bitriseAuthentication()
        interface.actionHandler = { [weak self] module, action in
            self?.bitriseAuthentication(module: module, didPerformAction: action)
        }
        return interface.rootViewController
    }

    func bitriseAuthentication(
        module: BitriseAuthenticationModule,
        didPerformAction action: BitriseAuthenticationModuleAction
    ) {
        switch action {
        case .tokenCreated:
            presentEnterTokenScreen()
        }
    }
}
