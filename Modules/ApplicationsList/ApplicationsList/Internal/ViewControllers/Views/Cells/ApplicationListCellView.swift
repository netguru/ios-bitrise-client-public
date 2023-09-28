//
//  ApplicationListCellView.swift
//  ApplicationsList
//
//  Created by Leszek Barszcz on 14/07/2022.
//

import UIKit
import Common
import CommonUI

/// Class defines cell layout for `ApplicationListViewController`
final class ApplicationListCellView: UITableViewCell {
    /// substitute of popular UIKit extension for reuse identifiers
    static var reuseIdentifier: String { String(describing: Self.self) }

    private var avatarImage: UIImageView?
    private var projectLabel: CoreLabel?
    private var projectDescriptionLabel: CoreLabel?
    private var labelsStack: UIStackView?
    private var chevronImage: UIImageView?

    /// Property defines cell model (`BitriseApplication` of module `Common`) which is being delivered
    /// by networking layer
    var model: BitriseApplication? {
        didSet {
            self.projectLabel?.text = model?.title
            self.projectDescriptionLabel?.text = model?.projectType?.rawValue
        }
    }

    /// Look for superclass documentation. Override executes view setup as addition
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    /// Not used in this project but required by compilator
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ApplicationListCellView {
    func setupView() {
        setupAvatarView()
        setupLabels()
        setupChevron()
    }

    func setupAvatarView() {
        // to be replaced with proper CommonUI component
        let avatarImage = UIImageView()
        avatarImage.backgroundColor = .blue
        avatarImage.layer.cornerRadius = 25.0
        contentView.addSubview(avatarImage)
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        avatarImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        avatarImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        avatarImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        avatarImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.avatarImage = avatarImage
    }

    func setupLabels() {
        guard let avatarImage = avatarImage else { return }

        let vStack = UIStackView()
        vStack.axis = .vertical

        let projectLabel = CoreLabel()
        vStack.addArrangedSubview(projectLabel)
        self.projectLabel = projectLabel

        let projectDescLabel = CoreLabel()
        vStack.addArrangedSubview(projectDescLabel)
        projectDescriptionLabel = projectDescLabel

        contentView.addSubview(vStack)
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 16).isActive = true
        vStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        labelsStack = vStack
    }

    func setupChevron() {
        guard let stack = labelsStack else { return }

        let chevron = UIImageView(image: UIImage(systemName: "chevron.right"))
        contentView.addSubview(chevron)
        chevron.translatesAutoresizingMaskIntoConstraints = false
        chevron.leadingAnchor.constraint(greaterThanOrEqualTo: stack.trailingAnchor, constant: 16).isActive = true
        chevron.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        chevron.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
    }
}
