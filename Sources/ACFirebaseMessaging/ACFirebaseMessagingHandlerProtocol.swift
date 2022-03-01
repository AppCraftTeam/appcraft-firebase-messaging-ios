//
//  ACFirebaseMessagingHandlerProtocol.swift
//  
//
//  Created by Дмитрий Поляков on 01.03.2022.
//

import Foundation
import UserNotifications

public protocol ACFirebaseMessagingHandlerProtocol: NSObject, UNUserNotificationCenterDelegate {
    func handleApplicationLaunchNotification(_ data: [AnyHashable: Any])
}
