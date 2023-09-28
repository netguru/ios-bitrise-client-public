#!/usr/bin/env swift
import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
/*
 Helper functions
 */

@discardableResult func runProcess(_ command: String) -> String? {
    let process = Process()
    process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
    process.arguments = command.split(separator: " ").map { String($0) }
    let pipe = Pipe()
    process.standardOutput = pipe
    try? process.run()
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let result = String(data: data, encoding: String.Encoding.utf8)
    print(result!)
    return result
}

[
    "Modules/Common/project.yml",
    "Modules/Networking/project.yml",
    "Modules/CommonUI/project.yml",
    "Modules/ApplicationDetails/project.yml",
    "Modules/ApplicationsList/project.yml",
    "Modules/BitriseAuthentication/project.yml",
    "Modules/BuildsList/project.yml",
    "Modules/GeneralScreens/project.yml",
    "Modules/StartBuild/project.yml",
    "project.yml"
].forEach {
    runProcess("xcodegen -s \($0)")
}

print("Running pods. Please wait.")
runProcess("bundle exec pod install")
print("Done.")
let path = "BitriseClient.xcworkspace/xcshareddata/IDETemplateMacros.plist"
let exist = FileManager.default.fileExists(atPath: path)
if !exist {
    try? FileManager.default.createDirectory(atPath: "BitriseClient.xcworkspace/xcshareddata/", withIntermediateDirectories: true, attributes: nil)
    print("Header file does not exist. Fixing...")
    let content = """
    <?xml version=\"1.0\" encoding=\"UTF-8\"?>
    <!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">
    <plist version=\"1.0\">
    <dict>
    <key>FILEHEADER</key>
    <string>
    //  ___FILENAME___
    //  ___PACKAGENAME___
    //</string>
    </dict>
    </plist>
    """
    try! content.write(to: URL(fileURLWithPath: path), atomically: true, encoding: .utf8)
    print("Done.")
}
