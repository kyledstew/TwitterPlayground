TwitterPlayground

This app utilizes the Twitter Public API to search Tweets, and display trending topics in the users area.

The networking solution was all designed and implemented by Kyle Stewart.
Althought this app only has one server it interacts with, by utilizing `Endpoint`, `Router` and `Interceptor` objects, the logic behind reauthenticating and handlind server specific logic is possible, yet still using the same Networking class that performs the network requests via `URLSession`. 

Technologies Used in this app:
1. SwiftUI/Combine
2. PromiseKit
3. CoreLocation

