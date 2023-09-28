import UIKit
import ApplicationDetails
import Common

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        let interface = ApplicationDetailsModule.create(
            setup: ApplicationDetailsModuleSetup(
                application: BitriseApplication(
                    slug: "slug",
                    title: "title",
                    projectType: nil,
                    buildStatus: .inProgress,
                    repoUrl: "url"
                ),
                networkService: .mock,
                buildsViewController: UIViewController(),
                startBuildViewController: UIViewController()
            )
        )
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = interface.rootViewController
        window?.makeKeyAndVisible()

        return true
    }
}
