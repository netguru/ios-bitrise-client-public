import UIKit
import BitriseAuthentication

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        let interface = BitriseAuthenticationModule.create(setup: BitriseAuthenticationModuleSetup())
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = interface.rootViewController
        window?.makeKeyAndVisible()

        return true
    }
}
