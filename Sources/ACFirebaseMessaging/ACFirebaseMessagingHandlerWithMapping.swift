//
//  ACFirebaseMessagingHandlerWithMapping.swift
//  
//
//  Created by Дмитрий Поляков on 01.03.2022.
//

import Foundation
import UserNotifications

open class ACFirebaseMessagingHandlerWithMapping<Model: ACFirebaseMessagingNotificationModelProtocol>: NSObject, ACFirebaseMessagingHandlerProtocol {
    
    public typealias NotificationModel = Model
    public typealias NotificationModelClosure = (NotificationModel) -> Void
    
    // MARK: - Props
    public var didDidReceiveNotification: NotificationModelClosure?
    public var willPresentNotification: NotificationModelClosure?
    public var didHandleApplicationLaunchNotification: NotificationModelClosure?
    
    // MARK: - PushNotificationHandlerProtocol
    open func handleApplicationLaunchNotification(_ data: [AnyHashable: Any]) {
        guard let model = Model(userInfo: data) else { return }
        self.didHandleApplicationLaunchNotification?(model)
    }
    
    // MARK: - UNUserNotificationCenterDelegate
    open func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        print("[ACFirebaseMessagingHandlerWithMapping] - [willPresent] - identifier:", response.notification.request.identifier)
        completionHandler()
        
        guard let model = Model(notificationResponse: response) else { return }
        self.didDidReceiveNotification?(model)
    }

    open func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        print("[ACFirebaseMessagingHandlerWithMapping] - [willPresent] - identifier:", notification.request.identifier)
        completionHandler(.all)
        
        guard let model = Model(notification: notification) else { return }
        self.willPresentNotification?(model)
    }
}
