//
//  PeoductList+Extension.swift
//  Assignment
//
//  Created by Abhay Chaurasia on 12/05/25.
//
import UIKit
extension ProductListVC {
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, _ in
            print(granted ? "✅ Notifications allowed" : "❌ Denied")
            DispatchQueue.main.async {
               // self.valueToggle.text = granted ? "Notifications allowed" : " Notifications Denied"
               // self.toggle.isOn = granted
                if granted {
                    UserDefaults.standard.set(true, forKey: "notificationsEnabled")
                }
                else {
                    UserDefaults.standard.set(false, forKey: "notificationsEnabled")
                }
               
                let isNotificationEnabled = UserDefaults.standard.bool(forKey: "notificationsEnabled")

                self.toggle.isOn = isNotificationEnabled
                self.valueToggle.text = isNotificationEnabled ? "Notifications allowed" : " Notifications Denied"
            }

        }
    }
    func showDeletionNotification(item: String) {
        let isNotificationEnabled = UserDefaults.standard.bool(forKey: "notificationsEnabled")

           guard isNotificationEnabled else {
               print("🔕 Notifications are disabled, so skipping alert.")
               return
           }


        let content = UNMutableNotificationContent()
        content.title = "Deleted"
        content.body = "\(item) removed from Core Data"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    func showNotificationDeniedAlert() {
        let alert = UIAlertController(title: "Notifications Disabled",
                                      message: "Please enable notifications from Settings to receive alerts.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }

    func serviceError(responseCode : String) {

        let alert = UIAlertController(title: "Service Error",
                                      message: responseCode,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    func stopAnimation() {
        DispatchQueue.main.async{
            self.activityIndicator.stopAnimating()
        }
    }
    func startAnimation() {
        DispatchQueue.main.async{
            self.activityIndicator.startAnimating()
        }
    }
}
