//
//  MainViewController.swift
//  GeneralScreens
//

import UIKit

protocol MainViewControllerDelegate: AnyObject {
    func mainView(
        viewController: MainViewController,
        didPerformAction action: MainViewController.Action
    )
}

public final class MainViewController: UIViewController {
    enum Action {
        case createTokenSelected
        case enterTokenSelected
    }

    private let mainView = MainView()
    weak var delegate: MainViewControllerDelegate?

    override public func loadView() {
        view = mainView
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        mainView.createTokenButton.addTarget(self, action: #selector(createTokenButtonTapped), for: .touchUpInside)
        mainView.enterTokenButton.addTarget(self, action: #selector(enterTokenButtonTapped), for: .touchUpInside)
    }
}

private extension MainViewController {
    @objc func createTokenButtonTapped() {
        delegate?.mainView(viewController: self, didPerformAction: .createTokenSelected)
    }

    @objc func enterTokenButtonTapped() {
        delegate?.mainView(viewController: self, didPerformAction: .enterTokenSelected)
    }
}
