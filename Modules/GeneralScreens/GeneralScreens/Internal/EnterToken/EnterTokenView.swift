//
//  EnterTokenView.swift
//  GeneralScreens
//

import CommonUI
import UIKit

final class EnterTokenView: UIView {

    let titleLabel: CoreLabel = {
        let label = CoreLabel()
        label.text = "Token"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let tokenTextField: CoreField = {
        let textField = CoreField()
        textField.placeholder = "Enter token here"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let continueButton: ActionableButton = {
        let button = ActionableButton()
        button.setTitle("Continue", for: .normal)
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

        let inputStackView = UIStackView()
        inputStackView.axis = .vertical
        inputStackView.spacing = 10
        inputStackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(inputStackView)
        inputStackView.addArrangedSubview(titleLabel)
        inputStackView.addArrangedSubview(tokenTextField)
        addSubview(continueButton)

        let constraints = [
            inputStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            inputStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            inputStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            continueButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            continueButton.widthAnchor.constraint(equalToConstant: 200),
            continueButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}
