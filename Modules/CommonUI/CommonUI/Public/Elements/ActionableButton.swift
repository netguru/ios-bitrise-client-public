//
//  ActionableButton.swift
//  CommonUI
//

import UIKit

public final class ActionableButton: UIButton {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAppearance()
    }
}

private extension ActionableButton {
    func setupAppearance() {
        titleLabel?.font = .avertaStdRegular(ofSize: titleLabel?.font.pointSize ?? 15.0)
        backgroundColor = AppColors.main.color
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 10
        heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
    }
}
