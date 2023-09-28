//
//  UIFont+CustomFontLoading.swift
//  CommonUI
//

import UIKit

enum FontLoadingError: Error {
    case fileNotFound(name: String)
    case fileCouldNotBeRead(name: String)
    case providerCouldNotBeEstablished(name: String)
    case dataDoesNotContainAFont(name: String)
    case failedToRegisterFont(name: String)

    var localizedDescription: String {
        switch self {
        case let .fileNotFound(name):
            return "The file \"\(name)\" could not have been found"
        case let .fileCouldNotBeRead(name):
            return "The file \"\(name)\" could not have been read"
        case let .providerCouldNotBeEstablished(name):
            return "A provider for the data from the file \"\(name)\" "
                + "could not have been established"
        case let .dataDoesNotContainAFont(name):
            return "The data from the file \"\(name)\" does not contain a font"
        case let .failedToRegisterFont(name):
            return "Failed to register font \"\(name)\""
                + " - register graphics font failed"
                + " - this font may have already been registered in the main bundle."
        }
    }
}

extension UIFont {

    static func loadFontWith(name: String, ofType type: String = "otf") throws {
        let fileName = "\(name).\(type)"
        let frameworkBundle = Bundle(for: CommonUIModule.self)
        guard let pathForResourceString = frameworkBundle.path(forResource: name, ofType: type) else {
            throw FontLoadingError.fileNotFound(name: fileName)
        }
        guard let fontData = NSData(contentsOfFile: pathForResourceString) else {
            throw FontLoadingError.fileCouldNotBeRead(name: fileName)
        }
        guard let dataProvider = CGDataProvider(data: fontData) else {
            throw FontLoadingError.providerCouldNotBeEstablished(name: fileName)
        }
        guard let fontRef = CGFont(dataProvider) else {
            throw FontLoadingError.dataDoesNotContainAFont(name: fileName)
        }

        var errorRef: Unmanaged<CFError>?

        guard CTFontManagerRegisterGraphicsFont(fontRef, &errorRef) == true else {
            let fontName: String
            if let cfName = fontRef.fullName {
                fontName = cfName as String
            } else {
                fontName = name
            }
            throw FontLoadingError.failedToRegisterFont(name: fontName)
        }
    }
}
