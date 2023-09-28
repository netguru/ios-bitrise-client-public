//
//  NavigationBarDecorator.swift
//  CommonUI
//

import UIKit

public enum NavigationBarDecorator {
    public static func setupAppearance() {
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).textColor = AppColors.main.color
        UIButton.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).tintColor = AppColors.main.color
        UINavigationBar.appearance().tintColor = AppColors.main.color
    }
}
