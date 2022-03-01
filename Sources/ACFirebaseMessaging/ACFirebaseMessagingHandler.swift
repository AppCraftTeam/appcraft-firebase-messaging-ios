//
//  ACFirebaseMessagingHandler.swift
//  
//
//  Created by Дмитрий Поляков on 01.03.2022.
//

import Foundation
import UserNotifications

open class ACFirebaseMessagingHandler: NSObject, ACFirebaseMessagingHandlerProtocol {
    
    public typealias NotificationData = [AnyHashable: Any]
    public typealias NotificationDataClosure = (NotificationData) -> Void
    
    // MARK: - Props
    public var didDidReceiveNotification: NotificationDataClosure?
    public var willPresentNotification: NotificationDataClosure?
    public var didHandleApplicationLaunchNotification: NotificationDataClosure?
    
    // MARK: - PushNotificationHandlerProtocol
    open func handleApplicationLaunchNotification(_ data: [AnyHashable: Any]) {
        self.didHandleApplicationLaunchNotification?(data)
    }
    
    // MARK: - UNUserNotificationCenterDelegate
    open func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        print("[ACFirebaseMessagingHandler] - [willPresent] - identifier:", response.notification.request.identifier)
        completionHandler()
        self.didDidReceiveNotification?(response.notification.request.content.userInfo)
    }

    open func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        print("[ACFirebaseMessagingHandler] - [willPresent] - identifier:", notification.request.identifier)
        completionHandler(.all)
        self.willPresentNotification?(notification.request.content.userInfo)
    }
    
}
