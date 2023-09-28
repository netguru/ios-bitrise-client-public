//
//  CoreFont.swift
//  CommonUI
//

import UIKit

extension UIFont {
    static func avertaStdRegular(forStyle style: CoreLabel.TextStyle
    ) -> UIFont {
        let size: CGFloat
        switch style {
        case .header:
            size = 24
        case .title:
            size = 17
        case .body:
            size = 15
        }
        return avertaStdRegular(ofSize: size)
    }

    static func avertaStdRegular(
        ofSize size: CGFloat,
        weight: UIFont.Weight = .regular
    ) -> UIFont {
        let name: String
        switch weight {
        // TODO: Add support for other weights
        default:
            name = "AvertaStd-Regular"
        }
        return UIFont(name: name, size: size) ?? systemFont(ofSize: size)
    }
}
