//
//  BuildsListFlowController.swift
//  BuildsList
//

import Common
import Networking
import UIKit

final class BuildsListFlowController: FlowController {

    var rootViewController: UIViewController {
        listViewController
    }

    private lazy var listViewController = BuildsListViewController()
    private let dataProvider: DataService

    init(application: BitriseApplication, networkService: NetworkService) {
        dataProvider = DefaultDataService(networkService: networkService)
        dataProvider.provideBuilds(for: application) { [weak self] result in
            switch result {
            case let .success(builds):
                self?.listViewController.builds = builds
            case let .failure(error):
                print(error)
            }
        }
    }
}
