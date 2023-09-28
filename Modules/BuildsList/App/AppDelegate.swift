import BuildsList
import Common
import Networking
import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        let interface = BuildsListModule.create(
            setup: BuildsListModuleSetup(
                application: BitriseApplication(
                    slug: "slug",
                    title: "title",
                    projectType: nil,
                    buildStatus: .inProgress,
                    repoUrl: "url"
                ),
                networkService: .mock
            )
        )
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = interface.rootViewController
        window?.makeKeyAndVisible()

        return true
    }
}
