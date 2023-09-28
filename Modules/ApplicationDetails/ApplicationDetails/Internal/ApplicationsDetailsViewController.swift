//
//  ApplicationsDetailsViewController.swift
//  ApplicationDetails
//

import UIKit

protocol ApplicationsDetailsViewControllerDelegate: AnyObject {
    func applicationDetails(
        viewController: ApplicationsDetailsViewController,
        didPerformAction action: ApplicationsDetailsViewController.Action
    )
}

final class ApplicationsDetailsViewController: UITabBarController {
    enum Action {
        case viewDisappeared
    }

    weak var applicationDetailsDelegate: ApplicationsDetailsViewControllerDelegate?

    init(
        buildsViewController: UIViewController,
        startBuildViewController: UIViewController,
        ymlViewController: UIViewController
    ) {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        setupWith(
            buildsViewController: buildsViewController,
            startBuildViewController: startBuildViewController,
            ymlViewController: ymlViewController
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupWith(
        buildsViewController: UIViewController,
        startBuildViewController: UIViewController,
        ymlViewController: UIViewController
    ) {
        tabBar.backgroundColor = .white
        viewControllers = [
            buildsViewController,
            startBuildViewController,
            ymlViewController
        ]
        buildsViewController.tabBarItem.title = "Builds"
        buildsViewController.tabBarItem.image = UIImage(systemName: "doc.on.doc")

        startBuildViewController.tabBarItem.title = "Start"
        startBuildViewController.tabBarItem.image = UIImage(systemName: "play")

        ymlViewController.tabBarItem.title = "YML"
        ymlViewController.tabBarItem.image = UIImage(systemName: "text.justify")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        applicationDetailsDelegate?.applicationDetails(viewController: self, didPerformAction: .viewDisappeared)
    }
}
