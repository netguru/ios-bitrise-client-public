//
//  ShowcaseViewController.swift
//  CommonUI
//

import UIKit

public final class ShowcaseViewController: UIViewController {

    private let navigationBarDecorator: NavigationBarDecorator.Type
    private var showcaseView: ShowcaseView?

    public init(navigationBarDecorator: NavigationBarDecorator.Type = NavigationBarDecorator.self) {
        self.navigationBarDecorator = navigationBarDecorator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        navigationBarDecorator = NavigationBarDecorator.self
        super.init(coder: coder)
    }

    override public func loadView() {
        let showcaseView = ShowcaseView()
        view = showcaseView
        self.showcaseView = showcaseView
    }
}
