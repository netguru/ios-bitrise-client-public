//
//  AccountDetailsView.swift
//  GeneralScreens
//

import CommonUI
import UIKit

final class AccountDetailsView: UIView {

    let usernameLabel: CoreLabel = {
        let label = CoreLabel()
        label.text = "username"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let emailLabel: CoreLabel = {
        let label = CoreLabel()
        label.text = "email"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let logoutButton: ActionableButton = {
        let button = ActionableButton()
        button.setTitle("logout", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .white

        addSubview(usernameLabel)
        addSubview(emailLabel)
        addSubview(logoutButton)

        let constraints = [
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            usernameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),

            emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            emailLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 10),

            logoutButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
            logoutButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
            logoutButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -300)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}
