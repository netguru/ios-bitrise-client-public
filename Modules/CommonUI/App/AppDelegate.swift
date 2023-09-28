import UIKit
import CommonUI

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = CommonUIModule.create(setup: CommonUIModuleSetup()).rootViewController
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        // Here you can build a list of common UI elements that a developer can quickly check
        // how they look like, how they can be customized, and how much they're adaptive.
        // Think of it as a storybook fot frontend.

        return true
    }
}
