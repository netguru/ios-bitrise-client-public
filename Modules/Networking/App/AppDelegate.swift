import Common
import Networking
import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var module: NetworkingModuleInterface!

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = UIViewController()
        viewController.view.backgroundColor = .red
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        /*
         In Demo App you can provide a POSTMAN like interface
         for defining requests and checking the content of responses.
         */

        let credentialStorage = CommonModule.create(setup: CommonModuleSetup()).credentialStorage
        credentialStorage.storeToken(token: "asd") { _ in }
        module = NetworkingModule.create(
            setup: NetworkingModuleSetup(
                scheme: .https,
                host: "api.bitrise.io/v0.1",
                version: "1",
                credentialsStorage: credentialStorage
            )
        )
        module.service.sendRequest(request: TestRequest()) { result in
            print(result)
        }
        return true
    }
}

struct TestRequest: ApiRequest {
    var path: String = "addons"

    var parameters: [String: Any]?

    var method: HTTPMethod = .GET

    typealias Response = AddonsResponse
}

struct AddonsResponse: Decodable {
    let data: [Addon]
}

struct Addon: Decodable {

    let id: String
    let title: String
}
