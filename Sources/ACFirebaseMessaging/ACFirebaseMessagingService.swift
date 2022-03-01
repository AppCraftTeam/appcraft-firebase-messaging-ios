//
//  ACFirebaseMessagingService.swift
//  
//
//  Created by Дмитрий Поляков on 01.03.2022.
//

import Foundation
import FirebaseMessaging
import UIKit

open class ACFirebaseMessagingService: NSObject, MessagingDelegate {
    
    // MARK: - Props
    public private(set) var fcmToken: String?
    open var handlers = ACFirebaseMessagingHandlers()
    
    // MARK: - Methods
    open func clearBadge() {
        print("[ACFirebaseMessagingService] - [clearBadge]")

        DispatchQueue.main.async {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
    
    open func configure(applicationLaunchOptions options: [UIApplication.LaunchOptionsKey: Any]?) {
        print("[ACFirebaseMessagingService] - [configure] - options:", options ?? "nil")

        Messaging.messaging().delegate = self
        self.handlers.subscribeCurrent()

        guard let data = options?[.remoteNotification] as? [AnyHashable: Any] else { return }
        print("[ACFirebaseMessagingService] - [configure] - data:", data)
        self.handlers.appLaunchNotification = data
    }
    
    open func requestAuthorization() {
        print("[ACFirebaseMessagingService] - [requestAuthorization]")

        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound]) { granted, error in
            print("[ACFirebaseMessagingService] - [requestAuthorization] - requestAuthorization - granted:", granted, "| error:", error ?? "nil")
            
            DispatchQueue.main.async { [weak self] in
                UIApplication.shared.registerForRemoteNotifications()
                self?.handlers.subscribeCurrent()
            }
        }
    }
    
    open func uploadFcmToken() {
        print("[ACFirebaseMessagingService] - [uploadFcmToken]")
    }

    open func deleteFcmToken() {
        print("[ACFirebaseMessagingService] - [deleteFcmToken]")
    }
    
    // MARK: - MessagingDelegate
    open func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("[ACFirebaseMessagingService] - [didReceiveRegistrationToken] - fcmToken:", fcmToken ?? "nil")

        self.fcmToken = fcmToken
        self.uploadFcmToken()
    }
    
}
