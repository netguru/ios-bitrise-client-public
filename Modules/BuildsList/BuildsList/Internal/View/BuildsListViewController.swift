//
//  BuildsListViewController.swift
//  BuildsList
//

import UIKit
import Common
import CommonUI

final class BuildsListViewController: UIViewController {

    var builds: [BitriseAppBuild] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }

    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.dataSource = self
        view.delegate = self
        return view
    }()

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
        title = "Builds"
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 75
        tableView.register(
            BuildsListCell.self,
            forCellReuseIdentifier: BuildsListCell.identifier
        )
    }
}

extension BuildsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: BuildsListCell.identifier,
            for: indexPath
        ) as? BuildsListCell else {
            return UITableViewCell()
        }
        let build = builds[indexPath.row]

        cell.configure(
            state: cellState(for: build.status),
            workflowName: build.triggeredWorkflow,
            startTime: build.startedOnWorkerAt ?? build.triggeredAt,
            endTime: build.finishedAt
        )

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        builds.count
    }

    private func cellState(for status: BitriseBuildStatus) -> BuildsListCell.State {
        switch status {
        case .notFinished:
            return .inProgress
        case .success:
            return .completedSuccessfully
        case .error, .unknown, .abortedWithError, .abortedWithSuccess:
            return .failed
        }
    }
}
