import UIKit

@main
final class AppDelegate: UIResponder {

    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    // MARK: Private

    private lazy var appFlowController = AppFlowController()
}

extension AppDelegate: UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        UIDecorator.decorate()
        guard let window = window else {
            return true
        }
        window.rootViewController = appFlowController.rootViewController
        window.makeKeyAndVisible()
        return true
    }
}
