//
//  ApplicationsListViewController.swift
//  ApplicationsList
//

import UIKit
import Common
import CommonUI

protocol ApplicationsListViewControllerDelegate: AnyObject {
    func applicationsList(
        viewController: ApplicationsListViewController,
        didPerformAction action: ApplicationsListViewController.Action
    )
}

final class ApplicationsListViewController: UIViewController {
    enum Action {
        case refresh
        case selected(application: BitriseApplication)
        case avatarTapped
    }

    var applications: [BitriseApplication] = [] {
        didSet {
            filteredApplications = applications
        }
    }

    var filteredApplications: [BitriseApplication] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    let searchController = UISearchController(searchResultsController: nil)

    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.delegate = self
        view.dataSource = self
        return view
    }()

    weak var delegate: ApplicationsListViewControllerDelegate?

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Applications"
        tableView.register(
            ApplicationListCellView.self,
            forCellReuseIdentifier: ApplicationListCellView.reuseIdentifier
        )

        setupSearchController()

        let avatar = UIImage(systemName: "person.crop.circle")
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: avatar,
            style: .plain,
            target: self,
            action: #selector(didTapAvatar)
        )
        delegate?.applicationsList(viewController: self, didPerformAction: .refresh)
    }

    @objc private func didTapAvatar() {
        delegate?.applicationsList(viewController: self, didPerformAction: .avatarTapped)
    }
}

extension ApplicationsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ApplicationListCellView.reuseIdentifier,
            for: indexPath
        ) as? ApplicationListCellView else {
            return UITableViewCell()
        }

        cell.model = filteredApplications[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredApplications.count
    }
}

extension ApplicationsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let application = filteredApplications[indexPath.row]
        delegate?.applicationsList(viewController: self, didPerformAction: .selected(application: application))
    }
}

extension ApplicationsListViewController: UISearchControllerDelegate, UISearchResultsUpdating {

    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search applications"
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationController?.view.setNeedsLayout()
    }

    func didDismissSearchController(_ searchController: UISearchController) {
        filteredApplications = applications
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredApplications = applications
            return
        }
        filteredApplications = applications.filter {
            $0.title.lowercased().contains(filter.lowercased())
        }
    }
}
