//
//  CoreLabel.swift
//  CommonUI
//

import UIKit

public final class CoreLabel: UILabel {

    // Controls the text style shown in label.
    public enum TextStyle {
        /// regular text
        case body
        /// biggest possible variant
        case header
        /// slightly bigger than body
        case title
    }

    /// Controls the text style shown in label.
    public var textStyle: TextStyle = .body {
        didSet {
            setupAppearance()
        }
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAppearance()
    }
}

private extension CoreLabel {
    func setupAppearance() {
        font = .avertaStdRegular(forStyle: textStyle)
        textColor = AppColors.main.color
    }
}
