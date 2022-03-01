//
//  UNNotificationPresentationOptions+Extensions.swift
//  
//
//  Created by Дмитрий Поляков on 01.03.2022.
//

import Foundation
import UserNotifications

public extension UNNotificationPresentationOptions {

    static let none: UNNotificationPresentationOptions = []

    static var all: UNNotificationPresentationOptions {
        var options: UNNotificationPresentationOptions = [.alert, .badge, .sound]

        if #available(iOS 14.0, *) {
            options.insert([.list, .banner])
        }

        return options
    }

}
