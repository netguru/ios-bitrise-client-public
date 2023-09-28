//
//  BitriseProjectType.swift
//  Common
//

public enum BitriseProjectType: String, Decodable {
    case android
    case flutter
    case iOS = "ios"
    case reactNative = "react-native"
    case other
}
