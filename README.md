TwitterPlayground

This app utilizes the Twitter Public API to search Tweets, and display trending topics in the users area.

Although this app only has one server it interacts with, by utilizing `Endpoint`, `Router` and `Interceptor` objects, the logic behind reauthenticating and handlind server specific logic is possible, yet still using the same Networking class that performs the network requests via `URLSession`. 

Technologies Used in this app:
1. SwiftUI/Combine
2. PromiseKit
3. CoreLocation

Things to Improve:

1. UI
The UI for this app was done while keeping on eye on my kids in the bath, so naturally there is room for improvement.
Fortunately this app was never intended to showcase my SwiftUI skills so I let that slide.

2. Error Handling
Currently if there is an error returned from any of the requests it is not displayed to the user.
On the Trends screen if the user does not give consent to share location data it will not prompt again.

3. Unit Tests
Again, wasn't the priority but would be good to have.
