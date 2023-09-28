//
//  CoreField.swift
//  CommonUI
//

import UIKit

public final class CoreField: UITextField {

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAppearance()
    }
}

private extension CoreField {
    func setupAppearance() {
        font = .avertaStdRegular(ofSize: font?.pointSize ?? 15.0)
    }
}
