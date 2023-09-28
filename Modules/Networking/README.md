# Networking Module

The goal for this module is to centralize the networking implementation.

### Usage
1. Define Endpoint
```swift
import Networking
struct ListEndpoint: Endpoint {
    let path: String = "list"
    let parameters: [String: Any]? = { "filter" : "completed" }
    let method: HTTPMethod = .GET
}
```
2. Allow injecting networkService to your module.
```swift
protocol ModuleFoundation {
    var networkService: NetworkService { get }
}
struct ModuleFlowController: FlowController {
    func startModule(with: ModuleFoundation) {
        // Intiliaze view controllers for module
    }
}
```
3. For the purpose of development, create `MockedNetworkService` which will help you with using mocked data.
```swift
import Networking
struct MockedNetworkService: NetworkService {
    func sendRequest<T: Decodable>(for endpoint: Endpoint, result: @escaping (Result<T, ApiError>) -> Void) {
      result(.success(#ObjectToReturn))
    }
}
```
4. In demo app use `MockedNetworkService` in `ModuleFoundation`.
