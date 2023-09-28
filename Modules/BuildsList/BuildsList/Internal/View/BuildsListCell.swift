//
//  BuildsListCell.swift
//  BuildsList
//

import UIKit
import CommonUI

protocol CellDateProvider {
    static var current: Date { get }
}

extension Date: CellDateProvider {
    static var current: Date {
        Date()
    }
}

/// Cell displaying the build information
final class BuildsListCell: UITableViewCell {

    static var identifier: String = "BuildsListCell"

    private static var startTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, HH:mm"
        formatter.locale = Locale(identifier: "en")
        return formatter
    }()

    enum State: String {
        case completedSuccessfully = "Success"
        case inProgress = "In Progress"
        case failed = "Failed"

        var backgroundColor: UIColor {
            switch self {
            case .completedSuccessfully:
                return .green
            case .inProgress:
                return .yellow
            case .failed:
                return .red
            }
        }
    }

    // MARK: - Private Properties

    /// State of the build the cell represents.
    private var state: State = .inProgress {
        didSet {
            contentView.backgroundColor = state.backgroundColor.withAlphaComponent(0.5)
            statusLabel.text = state.rawValue
        }
    }

    private let statusLabel: CoreLabel = {
        let statusLabel = CoreLabel(frame: .zero)
        statusLabel.text = "Status Label"
        statusLabel.textStyle = .title
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return statusLabel
    }()

    private let workflowLabel: CoreLabel = {
        let workflowLabel = CoreLabel(frame: .zero)
        workflowLabel.text = "Workflow"
        workflowLabel.textStyle = .title
        workflowLabel.translatesAutoresizingMaskIntoConstraints = false
        return workflowLabel
    }()

    private let startTimeLabel: CoreLabel = {
        let startTimeLabel = CoreLabel(frame: .zero)
        startTimeLabel.text = "Start time"
        startTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        return startTimeLabel
    }()

    private let buildTimeLabel: CoreLabel = {
        let buildTimeLabel = CoreLabel(frame: .zero)
        buildTimeLabel.text = "Build time"
        buildTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        return buildTimeLabel
    }()

    private var timer: Timer?
    private var startTime: Date?

    var dateProvider: CellDateProvider.Type = Date.self

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Interface Methods

    func configure(
        state: State,
        workflowName: String,
        startTime: Date?,
        endTime: Date?
    ) {
        self.state = state
        self.startTime = startTime
        if let startTime = startTime {
            startTimeLabel.text = Self.startTimeFormatter.string(from: startTime)
        } else {
            startTimeLabel.text = "Not yet started"
        }
        workflowLabel.text = workflowName
        timer?.invalidate()
        timer = nil
        if state == .inProgress {
            timer = Timer.scheduledTimer(
                timeInterval: 1,
                target: self,
                selector: #selector(timerTick),
                userInfo: nil,
                repeats: true
            )
            timerTick()
        } else if let startTime = startTime, let endTime = endTime {
            let diff = endTime.addingTimeInterval(-startTime.timeIntervalSince1970).timeIntervalSince1970
            presentDiff(diff)
        }
    }

    // MARK: - Private Methods

    private func layout() {
        contentView.backgroundColor = .white

        contentView.addSubview(statusLabel)
        contentView.addSubview(workflowLabel)
        contentView.addSubview(startTimeLabel)
        contentView.addSubview(buildTimeLabel)
        let margin: CGFloat = 10
        NSLayoutConstraint.activate([
            statusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin),
            statusLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: margin),

            startTimeLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 20),
            startTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin),
            startTimeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -margin),

            workflowLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: margin),
            workflowLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin),

            buildTimeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -margin),
            buildTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin)
        ])
    }

    @objc private func timerTick() {
        guard let startTime = startTime else {
            return
        }
        let diff = dateProvider.current.addingTimeInterval(-startTime.timeIntervalSince1970).timeIntervalSince1970
        presentDiff(diff)
    }

    private func presentDiff(_ diff: TimeInterval) {
        let minutes = Int(diff / 60)
        let seconds = diff.truncatingRemainder(dividingBy: 60)
        buildTimeLabel.text = "\(minutes) mins \(Int(seconds)) s"
    }
}
