//
//  AccountDetailsViewController.swift
//  GeneralScreens
//

import Common
import UIKit

protocol AccountDetailsViewControllerDelegate: AnyObject {
    func accountDetails(
        viewController: AccountDetailsViewController,
        didPerformAction action: AccountDetailsViewController.Action
    )
}

final class AccountDetailsViewController: UIViewController {
    enum Action {
        case logoutSelected
    }

    private let mainView = AccountDetailsView()
    private let storage: UserStorage
    weak var delegate: AccountDetailsViewControllerDelegate?

    init(storage: UserStorage) {
        self.storage = storage
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.logoutButton.addTarget(self, action: #selector(logoutSelected), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        storage.fetchUser { [weak self] result in
            switch result {
            case let .success(user):
                DispatchQueue.main.async {
                    self?.presentUserDetails(user)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}

private extension AccountDetailsViewController {
    func presentUserDetails(_ user: BitriseUser) {
        mainView.usernameLabel.text = user.username
        mainView.emailLabel.text = user.email
    }

    @objc func logoutSelected() {
        delegate?.accountDetails(viewController: self, didPerformAction: .logoutSelected)
    }
}
