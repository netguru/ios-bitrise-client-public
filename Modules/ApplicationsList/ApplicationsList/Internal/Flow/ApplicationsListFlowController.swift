//
//  ApplicationsListFlowController.swift
//  ApplicationsList
//

import Networking
import UIKit
import Common

protocol ApplicationsListFlowControllerDelegate: AnyObject {
    func flowController(_ flowController: ApplicationsListFlowController, didPerformFlow flow: ApplicationsListFlow)
}

final class ApplicationsListFlowController: FlowController {

    var rootViewController: UIViewController {
        listViewController
    }

    weak var delegate: ApplicationsListFlowControllerDelegate?

    private lazy var listViewController: ApplicationsListViewController = {
        let viewController = ApplicationsListViewController()
        viewController.delegate = self
        return viewController
    }()

    private let dataProvider: ApplicationsListDataProvider

    init(networkService: NetworkService) {
        dataProvider = ApplicationsListDataProvider(networkService: networkService)
    }
}

// MARK: ApplicationsListViewControllerDelegate

extension ApplicationsListFlowController: ApplicationsListViewControllerDelegate {
    func applicationsList(
        viewController: ApplicationsListViewController,
        didPerformAction action: ApplicationsListViewController.Action
    ) {
        switch action {
        case .refresh:
            dataProvider.fetchApplications { result in
                switch result {
                case let .success(applications):
                    DispatchQueue.main.async {
                        viewController.applications = applications
                    }
                case let .failure(error):
                    print("Handle error: \(error)")
                }
            }
        case let .selected(application):
            delegate?.flowController(self, didPerformFlow: .selected(application: application))
        case .avatarTapped:
            delegate?.flowController(self, didPerformFlow: .avatarTapped)
        }
    }
}
