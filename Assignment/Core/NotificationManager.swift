//
//  Untitled.swift
//  Assignment
//
//  Created by Abhay Chaurasia on 12/05/25.
//

import Foundation
import UserNotifications
import UIKit

class NotificationManager {
    static let shared = NotificationManager()

    private init() {}

    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                completion(true)

            case .notDetermined:
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
                    DispatchQueue.main.async {
                        completion(granted)
                    }
                }

            case .denied:
                DispatchQueue.main.async {
                    completion(false)
                }

            default:
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }
}
