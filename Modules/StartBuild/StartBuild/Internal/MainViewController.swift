//
//  MainViewController.swift
//  StartBuild
//

import Common
import Networking
import UIKit

final class MainViewController: UIViewController {
    private let mainView = MainView()

    var networkService: NetworkService
    var application: BitriseApplication

    init(networkService: NetworkService, application: BitriseApplication) {
        self.networkService = networkService
        self.application = application
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(workflows: [String]) {
        mainView.update(workflows: workflows)
    }

    override func loadView() {
        view = mainView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchWorkflows()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.onStartBuildAction = startBuild
    }

    private func fetchWorkflows() {
        networkService.sendRequest(request: BuildWorkflowsRequest(appSlug: application.slug)) { [weak self] result in
            switch result {
            case let .failure(error): print(error.localizedDescription)
            case let .success(response):
                DispatchQueue.main.async {
                    self?.update(workflows: response.workflows)
                }
            }
        }
    }

    private func startBuild(branch: String, workflow: String) {
        networkService.sendRequest(
            request: StartBuildRequest(
                appSlug: application.slug,
                branch: branch,
                workflow: workflow
            )
        ) { [weak self] result in
            switch result {
            case let .failure(error): print(error.localizedDescription)
            case let .success(response):
                DispatchQueue.main.async {
                    self?.presentConfirmationFor(response)
                }
            }
        }
    }

    private func presentConfirmationFor(_ response: StartBuildResponse) {
        let alert = UIAlertController(
            title: "Build \(response.buildNumber) Started",
            message: response.message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}
