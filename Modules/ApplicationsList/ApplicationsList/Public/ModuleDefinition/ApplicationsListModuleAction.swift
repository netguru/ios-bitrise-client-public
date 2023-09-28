//
//  ApplicationsListModuleAction.swift
//  ApplicationsList
//

import Common

public enum ApplicationsListModuleAction: ModuleAction {
    case selected(application: BitriseApplication)
    case avatarTapped
}
