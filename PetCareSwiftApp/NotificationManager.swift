//
//  NotificationSender.swift
//  PetCareSwiftApp
//
//  Created by Dan-Lucian Nita on 15.01.2023.
//

import Foundation
import UserNotifications

class NotificationManager {
        
    static let instance = NotificationManager() //singleton
    
    func requestAuthorization(){
        let options : UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (
            success, error) in
            if let error = error {
                print("Notifications error: \(error)")
            }
            else {
                print("Got notifications authorization")
            }
        }
    }
    
    func sendNotification(title : String, message : String){
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        content.sound = .default
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2.0, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        
        
    }
    
}
