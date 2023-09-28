//
//  MainView.swift
//  GeneralScreens
//

import CommonUI
import UIKit

final class MainView: UIView {

    let titleLabel: CoreLabel = {
        let label = CoreLabel()
        label.text = "Bitrise client"
        label.textStyle = .header
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let createTokenButton: ActionableButton = {
        let button = ActionableButton()
        button.setTitle("Create access token", for: .normal)
        return button
    }()

    let enterTokenButton: ActionableButton = {
        let button = ActionableButton()
        button.setTitle("Enter access token", for: .normal)
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

        let buttonStackView = UIStackView()
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 70
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(titleLabel)
        addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(createTokenButton)
        buttonStackView.addArrangedSubview(enterTokenButton)

        let constraints = [
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
            buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
            buttonStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -100)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}
