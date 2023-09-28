import Common
import GeneralScreens
import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController = UINavigationController()
    var interface: GeneralScreensModuleInterface?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        let credentialStorage = CommonModule.create(setup: CommonModuleSetup()).credentialStorage
        let interface = GeneralScreensModule.create(
            setup: GeneralScreensModuleSetup(credentialsStorage: credentialStorage)
        )
        self.interface = interface
        interface.actionHandler = { [weak self] _, action in
            self?.handle(action: action)
        }
        window = UIWindow(frame: UIScreen.main.bounds)
        navigationController.viewControllers = [interface.appInitialViewController]
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
}

private extension AppDelegate {
    func handle(action: GeneralScreensModuleAction) {
        switch action {
        case .enterTokenSelected:
            interface.flatMap { navigationController.pushViewController($0.enterTokenViewController, animated: true) }
        case .createTokenSelected:
            presentAlert(with: "Create token selected")
        case .tokenSaved:
            presentAlert(with: "Token saved")
        case .logoutSelected:
            presentAlert(with: "Logout selected")
        }
    }

    func presentAlert(with title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        navigationController.present(alert, animated: true)
    }
}
