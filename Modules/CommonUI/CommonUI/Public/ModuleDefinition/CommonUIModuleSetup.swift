//
//  CommonUIModuleSetup.swift
//  CommonUI
//

import Common
import UIKit

public struct CommonUIModuleSetup: ModuleSetup {
    public init() {}

    public func setupFonts() {
        do {
            try UIFont.loadFontWith(name: "Intelligent Design - AvertaStd-Regular")
        } catch {
            // TODO: Some actual logging infrastructure
            print(error.localizedDescription)
        }
    }
}
