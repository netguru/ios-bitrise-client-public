//
//  ShowcaseView.swift
//  CommonUIDemoApp
//

import UIKit

public final class ShowcaseView: UIView {
    private let button: ActionableButton
    private let field: CoreField
    private let placeholderField: CoreField
    private let label: CoreLabel
    private let stack: UIStackView

    override init(frame: CGRect) {
        button = ActionableButton()
        field = CoreField()
        placeholderField = CoreField()
        label = CoreLabel()
        stack = UIStackView()
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        button = ActionableButton()
        field = CoreField()
        placeholderField = CoreField()
        label = CoreLabel()
        stack = UIStackView()
        super.init(coder: coder)
        setupView()
    }
}

private extension ShowcaseView {
    func setupView() {
        setupViewHierarchy()
        setupLayout()
        setupPreviewData()
    }

    func setupViewHierarchy() {
        addSubview(stack)
        stack.addArrangedSubview(UIView())
        stack.addArrangedSubview(button)
        stack.addArrangedSubview(field)
        stack.addArrangedSubview(placeholderField)
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(UIView())
    }

    func setupLayout() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 15.0
        stack.axis = .vertical
        stack.alignment = .center

        button.translatesAutoresizingMaskIntoConstraints = false
        field.translatesAutoresizingMaskIntoConstraints = false
        placeholderField.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])

        backgroundColor = .white
    }

    func setupPreviewData() {
        button.setTitle("Button!", for: .normal)
        field.text = "Text"
        placeholderField.placeholder = "Placeholder"
        label.text = "Label text"
    }
}
