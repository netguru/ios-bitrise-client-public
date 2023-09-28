//
//  GeneralScreensFlowController.swift
//  GeneralScreens
//

import Common
import UIKit

protocol GeneralScreensFlowControllerDelegate: AnyObject {
    func flowController(_ flowController: GeneralScreensFlowController, didPerformFlow flow: GeneralScreensModuleAction)
}

final class GeneralScreensFlowController: FlowController {

    private let credentialsStorage: CredentialsStorage
    private let userStorage: UserStorage
    weak var delegate: GeneralScreensFlowControllerDelegate?

    var rootViewController: UIViewController {
        mainViewController
    }

    lazy var mainViewController: MainViewController = {
        let viewController = MainViewController()
        viewController.delegate = self
        return viewController
    }()

    lazy var enterTokenController: EnterTokenViewController = {
        let viewController = EnterTokenViewController(credentialsStorage: credentialsStorage)
        viewController.delegate = self
        return viewController
    }()

    lazy var accountDetailsController: AccountDetailsViewController = {
        let viewController = AccountDetailsViewController(storage: userStorage)
        viewController.delegate = self
        return viewController
    }()

    init(credentialsStorage: CredentialsStorage, userStorage: UserStorage) {
        self.credentialsStorage = credentialsStorage
        self.userStorage = userStorage
    }
}

extension GeneralScreensFlowController: MainViewControllerDelegate {
    func mainView(viewController: MainViewController, didPerformAction action: MainViewController.Action) {
        switch action {
        case .createTokenSelected:
            delegate?.flowController(self, didPerformFlow: .createTokenSelected)
        case .enterTokenSelected:
            delegate?.flowController(self, didPerformFlow: .enterTokenSelected)
        }
    }
}

extension GeneralScreensFlowController: EnterTokenViewControllerDelegate {
    func enterToken(
        viewController: EnterTokenViewController,
        didPerformAction action: EnterTokenViewController.Action
    ) {
        switch action {
        case .tokenSavedSuccessfully:
            delegate?.flowController(self, didPerformFlow: .tokenSaved)
        }
    }
}

extension GeneralScreensFlowController: AccountDetailsViewControllerDelegate {
    func accountDetails(
        viewController: AccountDetailsViewController,
        didPerformAction action: AccountDetailsViewController.Action
    ) {
        delegate?.flowController(self, didPerformFlow: .logoutSelected)
    }
}
