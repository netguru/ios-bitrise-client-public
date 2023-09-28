//
//  GuideViewController.swift
//  BitriseAuthentication
//

import CommonUI
import UIKit

protocol GuideViewControllerDelegate: AnyObject {
    func buttonTapped()
}

final class GuideViewController: UIViewController {

    weak var delegate: GuideViewControllerDelegate?

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [label, button])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()

    lazy var label: CoreLabel = {
        let label = CoreLabel()
        label.textColor = UIColor.black
        label.numberOfLines = 0
        return label
    }()

    lazy var button: ActionableButton = {
        let button = ActionableButton()
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()

    @objc func buttonTapped() {
        delegate?.buttonTapped()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        button.setTitle("Continue", for: .normal)
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints()
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
