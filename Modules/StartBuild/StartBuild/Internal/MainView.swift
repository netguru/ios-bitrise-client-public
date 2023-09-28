//
//  MainView.swift
//  StartBuild
//

import CommonUI
import UIKit

final class MainView: UIView {
    var onStartBuildAction: ((String, String) -> Void)?

    private var workflows = [String]()

    private let titleLabel: CoreLabel = {
        let label = CoreLabel()
        label.text = "Start new build"
        label.textStyle = .header
        label.textColor = .black
        return label
    }()

    private let branchLabel: CoreLabel = {
        let label = CoreLabel()
        label.text = "branch"
        label.textStyle = .title
        label.textColor = .black
        return label
    }()

    private let branchTextField: CoreField = {
        let textField = CoreField()
        textField.placeholder = "enter branch name"
        textField.textColor = .black
        textField.tintColor = .black
        textField.layer.borderWidth = 1
        textField.autocapitalizationType = .none
        textField.addTarget(nil, action: #selector(branchNameChanged), for: .editingChanged)
        return textField
    }()

    private let selectWorkflowPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()

    private let startButton: ActionableButton = {
        let button = ActionableButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.addTarget(nil, action: #selector(startBuild), for: .touchUpInside)
        button.isEnabled = false
        button.alpha = 0.4
        return button
    }()

    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setupSubviews()
        setupConstraints()
        selectWorkflowPickerView.delegate = self
        selectWorkflowPickerView.dataSource = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(workflows: [String]) {
        self.workflows = workflows
        selectWorkflowPickerView.reloadAllComponents()
    }

    @objc private func startBuild() {
        let selectedRow: Int = selectWorkflowPickerView.selectedRow(inComponent: 0)
        let selectedWorkflow = workflows[selectedRow]
        onStartBuildAction?(branchTextField.text ?? "", selectedWorkflow)
    }

    @objc private func branchNameChanged() {
        startButton.isEnabled = branchTextField.text?.isEmpty == false
        startButton.alpha = startButton.isEnabled ? 1 : 0.4
    }
}

extension MainView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {}

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        workflows.count
    }

    func pickerView(
        _ pickerView: UIPickerView,
        attributedTitleForRow row: Int,
        forComponent component: Int
    ) -> NSAttributedString? {
        NSAttributedString(string: workflows[row], attributes: [.foregroundColor: UIColor.black])
    }
}

private extension MainView {
    func setupSubviews() {
        [
            titleLabel,
            branchLabel,
            branchTextField,
            selectWorkflowPickerView,
            startButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }

    func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 96),

                branchLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                branchLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 48),

                branchTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
                branchTextField.topAnchor.constraint(equalTo: branchLabel.bottomAnchor, constant: 4),
                branchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 48),
                branchTextField.heightAnchor.constraint(equalToConstant: 48),

                selectWorkflowPickerView.centerXAnchor.constraint(equalTo: centerXAnchor),
                selectWorkflowPickerView.topAnchor.constraint(equalTo: branchTextField.bottomAnchor, constant: 48),

                startButton.centerXAnchor.constraint(equalTo: centerXAnchor),
                startButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -96),
                startButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 64),
                startButton.heightAnchor.constraint(equalToConstant: 48)
            ]
        )
    }
}
