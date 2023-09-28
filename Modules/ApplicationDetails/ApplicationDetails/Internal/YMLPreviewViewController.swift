//
//  YMLPreviewViewController.swift
//  ApplicationDetails
//

import Common
import Highlightr
import Networking
import UIKit

final class YMLPreviewViewController: UIViewController {

    private let application: BitriseApplication
    private let networkService: NetworkService

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    init(application: BitriseApplication, networkService: NetworkService) {
        self.application = application
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        view.addSubview(scrollView)
        scrollView.addSubview(label)
        let margin: CGFloat = 20
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: margin),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -margin),

            label.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: margin),
            label.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -margin),
            label.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: margin),
            label.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -margin)
        ])
        loadYML()
    }
}

private extension YMLPreviewViewController {

    func loadYML() {
        networkService.sendRequest(
            request: YMLDownloadRequest(appSlug: application.slug)
        ) { [weak self] result in
            switch result {
            case let .success(response):
                DispatchQueue.main.async {
                    self?.presentYML(string: response)
                }
            case let .failure(error):
                print(error)
            }
        }
    }

    func presentYML(string: String) {
        guard let highlightr = Highlightr() else {
            return
        }
        highlightr.setTheme(to: "paraiso-dark")
        let highlightedCode = highlightr.highlight(string, as: "yml")
        label.attributedText = highlightedCode
    }
}
