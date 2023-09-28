//
//  WebviewController.swift
//  BitriseAuthentication
//

import UIKit
import WebKit

protocol WebViewControllerDelegate: AnyObject {
    func webViewController(
        viewController: WebViewController,
        didPerformAction action: WebViewController.Action
    )
}

final class WebViewController: UIViewController, WKNavigationDelegate {
    enum Action {
        case authFlowFinished
    }

    private var webView: WKWebView!
    private var guideViewController = GuideViewController()
    private let helperTexts = [
        "Login to bitrise.io in the window above then click continue.",
        "Generate new personal access token, copy it to clipboard and select continue"
    ]

    weak var delegate: WebViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create token"
        webView = WKWebView()
        webView.navigationDelegate = self
        guard let url = URL(string: "https://app.bitrise.io/users/sign_in/") else { return }
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        guideViewController.delegate = self
        view.addSubview(webView)
        view.addSubview(guideViewController.view)
        addChild(guideViewController)
        guideViewController.didMove(toParent: self)
        addConstraints()
        guideViewController.label.text = helperTexts.first
    }

    private func addConstraints() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        guideViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            view.trailingAnchor.constraint(equalTo: webView.trailingAnchor),
            guideViewController.view.topAnchor.constraint(equalTo: webView.bottomAnchor),
            guideViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: guideViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: guideViewController.view.bottomAnchor),
            guideViewController.view.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}

extension WebViewController: GuideViewControllerDelegate {

    func buttonTapped() {
        guard
            let currentHelperText = guideViewController.label.text,
            let currentStep = helperTexts.firstIndex(of: currentHelperText)
        else {
            return
        }

        if currentStep == 0 {
            guard let url = URL(string: "https://app.bitrise.io/me/profile#/security") else { return }
            webView.load(URLRequest(url: url))
            guideViewController.label.text = helperTexts[1]
        } else if currentStep == 1 {
            let pasteboard = UIPasteboard.general
            if let item = pasteboard.string, item.count == 86 {
                delegate?.webViewController(viewController: self, didPerformAction: .authFlowFinished)
            } else {
                showError()
            }
        }
    }

    private func showError() {
        let alert = UIAlertController(title: "Error", message: "Token is not present in pasteboard. Copy it before using Continue", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
