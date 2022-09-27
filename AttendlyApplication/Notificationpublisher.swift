//
//  Notificationpublisher.swift
//  AttendlyApplication
//
//  Created by Sara Alsaleh on 01/03/1444 AH.
//

import UIKit
import UserNotifications
class  Notificationpublisher: NSObject {
    func sendNotification(title:String,
                          subtitle :String,
                          body:String,
                          badge: Int?,
                          dleayInterval: Int?) {
        let notifiationContent = UNMutableNotificationContent()
        notifiationContent.title = title
        notifiationContent.subtitle = subtitle
        notifiationContent.body = body
        var delayTimeTrigger : UNTimeIntervalNotificationTrigger?
        
        if let dleayInterval = dleayInterval {
            delayTimeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(dleayInterval), repeats: false)
        }
        
        if let badge = badge {
            var cuurentBadgcount = UIApplication.shared.applicationIconBadgeNumber
            cuurentBadgcount += badge
            notifiationContent.badge = NSNumber(integerLiteral: cuurentBadgcount)
        }
        notifiationContent.sound = UNNotificationSound.default
        
        UNUserNotificationCenter.current().delegate = self
        
        let request = UNNotificationRequest(identifier: "TestLocalNotification", content: notifiationContent, trigger: delayTimeTrigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            
            if let error = error {
                print(error.localizedDescription)
            }
            
        }
        
    }

                    
}
extension Notificationpublisher: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("the notification is about to be presented")
        completionHandler([.badge , .sound , .alert])
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let  identifer = response.actionIdentifier
        switch identifer {
            
        case UNNotificationDismissActionIdentifier:
            print("the notification was dismissed")
            completionHandler()
            
        case UNNotificationDefaultActionIdentifier:
            print("the user opend the app form notification")
            completionHandler()
            
        default:
            print("the defalut case was called")
            completionHandler()
        }
    }
    
}
