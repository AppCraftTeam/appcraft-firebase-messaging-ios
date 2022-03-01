//
//  ACFirebaseMessagingNotificationModelProtocol.swift
//  
//
//  Created by Дмитрий Поляков on 01.03.2022.
//

import Foundation
import UserNotifications

public protocol ACFirebaseMessagingNotificationModelProtocol {
    init?(userInfo: [AnyHashable: Any])
    init?(notificationResponse: UNNotificationResponse)
    init?(notification: UNNotification)
}

public extension ACFirebaseMessagingNotificationModelProtocol {
    init?(notificationResponse: UNNotificationResponse) {
        self.init(userInfo: notificationResponse.notification.request.content.userInfo)
    }

    init?(notification: UNNotification) {
        self.init(userInfo: notification.request.content.userInfo)
    }
}
