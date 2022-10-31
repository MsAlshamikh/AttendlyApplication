//
//  AppDelegate.swift
//  AttendlyApplication
//
//  Created by SHAMMA  on 17/02/1444 AH.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseMessaging

import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate ,MessagingDelegate,UNUserNotificationCenterDelegate {

    private func requestNotifiactionAuthorization(application: UIApplication){
        let center = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert , .badge , .sound]
        
        center.requestAuthorization(options: options ) { granted, error   in
            if let error  = error{
                print(error.localizedDescription)
            }
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        
        UNUserNotificationCenter.current().delegate = self
        //        let authoption : UNAuthorizationOptions = [.alert, .sound ,.badge ]
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound ,.badge ]){ success , _ in
                    guard success else{
                        return
                    }
        print("sucess in APNS rigistry")
                    }
                        application.registerForRemoteNotifications()


               // requestNotifiactionAuthorization(application: application)
       // Firestore.firestore().collection("TEST 123").document().setData(["1" : "1"])
      
//        UNUserNotificationCenter.current().delegate = self
//        let authoption : UNAuthorizationOptions = [.alert, .sound ,.badge ]
//        UNUserNotificationCenter.current().requestAuthorization(options: authoption){
//            success , error in
//            if error != nil{
//
//            }
//        }
//        application.registerForRemoteNotifications()
//       // usernoticationconfg()
        requestNotifiactionAuthorization(application: application)
       return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
            messaging.token{token ,_ in
                guard let token = token else {
                    return
                }
                print("Token:",token)
            }
        }





    private  func usernoticationconfg(){
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound])
            { (isApproved , error ) in

                if isApproved {
                    print("notification is approved")
                }else{
                    if let error  = error {
                        print("Error:  \(error.localizedDescription)")
                    }
                }
        }



}
}

//extension AppDelegate: UNUserNotificationCenterDelegate {
//
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        Messaging.messaging().apnsToken = deviceToken
//
//    }
//    func application(_ application: UIApplication, didFailToContinueUserActivityWithType userActivityType: String, error: Error) {
//        print("faild to reigster with puch")
//    }
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        print("will gets callled when app in forground with banner")
//        completionHandler([.alert , .sound, .badge])
//    }
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        print("will gets callled when user tap on notification")
//        completionHandler()
//    }
//
//
//}
//  private  func usernoticationconfg(){
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound])
//        { (isApproved , error ) in
//
//            if isApproved {
//                print("notification is approved")
//            }else{
//                if let error  = error {
//                    print("Error:  \(error.localizedDescription)")
//                }
//            }
//    }
//}
//}
