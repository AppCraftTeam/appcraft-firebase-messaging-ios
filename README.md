# ACFirebaseMessaging
Library for working with FirebaseMessaging.

[![version](https://img.shields.io/badge/version-0.0.1-white.svg)](https://semver.org)

## Requirements
* IOS 11 or above
* Xcode 12.5 or above


## Overview
[Classes](#Classes)\
[Install](#Install)\
[License](#License)\
[Author](#MVAuthorVM)

## Classes
The library contains the following entities:

### ACFirebaseMessagingManager
* Implements the `MessagingDelegate` protocol.
* Saves `fcmToken` inside.
* Contains `handlers` for handling received push-notifications.
* Сan control sending `fcmToken` to server.
* When starting an application called by a tap on a push-notification, it can receive the `userInfo` of this notification.
* Can request push-notification permissions.

```swift
open class ACFirebaseMessagingManager: NSObject, MessagingDelegate {
    public private(set) var fcmToken: String?
    open var handlers = ACFirebaseMessagingHandlers()
    
    open func clearBadge() {}
    open func configure(applicationLaunchOptions options: [UIApplication.LaunchOptionsKey: Any]?) {}
    open func requestAuthorization() {}
    open func uploadFcmToken() {}
    open func deleteFcmToken() {}
    
    open func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {}
}
```

Example of use in a project:

```swift
class AppPushNotificationManager: ACFirebaseMessagingManager {

    // Usage example as a singleton 
    static let shared = AppPushNotificationManager()

    override func uploadFcmToken() {
      guard let token = self.fcmToken else { return }
    
      // Load token to server
      ...
    }
      
    override func deleteFcmToken() {
        // Remove token from server
        ...
    }

}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        // Don't forget to call
        FirebaseApp.configure()

        AppPushNotificationManager.shared.configure(applicationLaunchOptions: launchOptions)
        ...
    }
    
}
```

### ACFirebaseMessagingHandlers
Stack of handlers. Transfers control initiative from last to first.

```swift
public struct ACFirebaseMessagingHandlers {
    public mutating func push(_ handler: ACFirebaseMessagingHandlerProtocol) {}
    public mutating func pop() {}
    public mutating func remove(_ handler: ACFirebaseMessagingHandlerProtocol) {}
}
```

### ACFirebaseMessagingHandler
Received notification handler. Implements the UNUserNotificationCenterDelegate protocol.

```swift
open class ACFirebaseMessagingHandler: NSObject, ACFirebaseMessagingHandlerProtocol {
    public typealias NotificationData = [AnyHashable: Any]
    public typealias NotificationDataClosure = (NotificationData) -> Void
    
    public var didDidReceiveNotification: NotificationDataClosure?
    public var willPresentNotification: NotificationDataClosure?
    public var didHandleApplicationLaunchNotification: NotificationDataClosure?
    ...
}
```

### ACFirebaseMessagingHandlerWithMapping
Performs the same functions as `ACFirebaseMessagingHandler`, but also maps the received notifications in essence corresponding to the `ACFirebaseMessagingNotificationModelProtocol` protocol.

```swift
open class ACFirebaseMessagingHandlerWithMapping<Model: ACFirebaseMessagingNotificationModelProtocol>: NSObject, ACFirebaseMessagingHandlerProtocol {
    public typealias NotificationModel = Model
    public typealias NotificationModelClosure = (NotificationModel) -> Void
    
    public var didDidReceiveNotification: NotificationModelClosure?
    public var willPresentNotification: NotificationModelClosure?
    public var didHandleApplicationLaunchNotification: NotificationModelClosure?
    ...
}
```

Example of use in a project:

```swift
class ViewController: UIViewController {

    lazy var pushNotificationHanlder: ACFirebaseMessagingHandler = {
      let result = ACFirebaseMessagingHandler()
      result.didDidReceiveNotification = { [weak self] _ in
          // Do something
          ...
      }
      ...
        
      return result
    }()
    
    // MARK: - Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Control will be given to `pushNotificationHanlder`
        AppPushNotificationManager.shared.handlers.push(self.pushNotificationHanlder)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Control will return to the previous handler
        AppPushNotificationManager.shared.handlers.remove(self.pushNotificationHanlder)
    }
}

```

## Install
Swift Package Manager(SPM) is Apple's dependency manager tool. It is now supported in Xcode 11. So it can be used in all appleOS types of projects. It can be used alongside other tools like CocoaPods and Carthage as well.

### Install package into your packages
Add a reference and a targeting release version in the dependencies section in Package.swift file:

```swift
import PackageDescription

let package = Package(
    name: "<your_project_name>",
    products: [],
    dependencies: [
        .package(url: "https://github.com/AppCraftTeam/appcraft-firebase-messaging-ios.git", from: "<current_version>")
    ]
)
```

### Install package via Xcode
1. Go to `File` -> `Swift Packages` -> `Add Package Dependency...`
2. Then search for <https://github.com/AppCraftTeam/appcraft-firebase-messaging-ios.git>
3. And choose the version you want

## License
Distributed under the MIT License.

## Author
Email: <dmitriyap11@gmail.com>
