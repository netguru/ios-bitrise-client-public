//
//  EnterTokenViewController.swift
//  GeneralScreens
//

import Common
import UIKit

protocol EnterTokenViewControllerDelegate: AnyObject {
    func enterToken(
        viewController: EnterTokenViewController,
        didPerformAction action: EnterTokenViewController.Action
    )
}

public final class EnterTokenViewController: UIViewController {
    enum Action {
        case tokenSavedSuccessfully
    }

    private let mainView = EnterTokenView()
    private let credentialsStorage: CredentialsStorage
    weak var delegate: EnterTokenViewControllerDelegate?

    init(credentialsStorage: CredentialsStorage) {
        self.credentialsStorage = credentialsStorage
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func loadView() {
        view = mainView
        title = "Enter token"
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        mainView.continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
    }
}

private extension EnterTokenViewController {

    @objc func continueTapped() {
        guard let token = mainView.tokenTextField.text, !token.isEmpty else {
            return
        }
        credentialsStorage.storeToken(token: token) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success:
                self.delegate?.enterToken(viewController: self, didPerformAction: .tokenSavedSuccessfully)
            case let .failure(error):
                self.presentAlert(for: error)
            }
        }
    }

    func presentAlert(for error: Error) {
        let alert = UIAlertController(
            title: "Could not save token",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
