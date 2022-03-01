//
//  ACFirebaseMessagingHandlers.swift
//  
//
//  Created by Дмитрий Поляков on 01.03.2022.
//

import Foundation
import UserNotifications

public struct ACFirebaseMessagingHandlers {
    
    // MARK: - Props
    public private(set) var handlers: [ACFirebaseMessagingHandlerProtocol] = []
    
    public var appLaunchNotification: [AnyHashable: Any]? {
        didSet {
            self.appLaunchNotificationDidSet()
        }
    }
    
    public var current: ACFirebaseMessagingHandlerProtocol? {
        self.handlers.last
    }
    
    // MARK: - Methods
    public func subscribeCurrent() {
        UNUserNotificationCenter.current().delegate = self.current
    }
    
    public mutating func push(_ handler: ACFirebaseMessagingHandlerProtocol) {
        self.remove(handler)
        self.handlers += [handler]
        
        self.subscribeCurrent()
        self.appLaunchNotificationDidSet()
    }

    public mutating func pop() {
        guard let handler = self.handlers.last else { return }
        self.remove(handler)
    }
    
    public mutating func remove(_ handler: ACFirebaseMessagingHandlerProtocol) {
        self.handlers.removeAll(where: { $0 == handler })
        self.subscribeCurrent()
    }
    
    public mutating func removeAll() {
        self.handlers.removeAll()
    }
    
    private mutating func appLaunchNotificationDidSet() {
        guard let data = self.appLaunchNotification, self.current != nil else { return }
        self.current?.handleApplicationLaunchNotification(data)
        self.appLaunchNotification = nil
    }
}
