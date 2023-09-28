//
//  UIDecorator.swift
//  BitriseClient
//

import CommonUI
import Foundation

enum UIDecorator {
    static func decorate() {
        NavigationBarDecorator.setupAppearance()
        TableCellDecorator.setupAppearance()
    }
}
