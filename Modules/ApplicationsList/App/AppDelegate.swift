import UIKit
import ApplicationsList

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        let interface = ApplicationsListModule.create(
            setup: ApplicationsListModuleSetup(networkService: .mock)
        )
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = interface.rootViewController
        window?.makeKeyAndVisible()

        return true
    }
}
