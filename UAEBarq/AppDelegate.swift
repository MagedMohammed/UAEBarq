//
//  AppDelegate.swift
//  UAEBarq
//
//  Created by Maged Omar on 5/1/20.
//  Copyright © 2020 Maged Omar. All rights reserved.
//

import UIKit
import Firebase
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate{
    // googleMapsKey =  AIzaSyA7b6KBKPD2bEcc5SR2nytghHYbgqfQBjw
    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // FireBase Configer
        FirebaseApp.configure()
        GMSServices.provideAPIKey("AIzaSyAGE9OuzP57FeBP1zvoNDN5b-VNvx5McKk")
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { (_, error) in
            guard error == nil else{
                print(error!.localizedDescription)
                return
            }
        }
        //get application instance ID
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instance ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
            }
        }
        application.registerForRemoteNotifications()
        
        return true
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
    }
    // end fireBase configer
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    // handling firebase Deep Link
    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
            let url = userActivity.webpageURL,
            let host = url.host else {
                return false
        }

        let isDynamicLinkHandled =
            DynamicLinks.dynamicLinks().handleUniversalLink(url) { dynamicLink, error in

                guard error == nil,
                    let dynamicLink = dynamicLink,
                    let urlString = dynamicLink.url?.absoluteString else {
                        return
                }
                print("Dynamic link host: \(host)")
                print("Dyanmic link url: \(urlString)")
                print("Dynamic link match type: \(dynamicLink.matchType.rawValue)")
            }
        return isDynamicLinkHandled
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        if let dynamicLink = DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url) {
            guard let urlString = dynamicLink.url?.absoluteString  else {
                return false
            }

            print("Dyanmic link url: \(urlString)")
            print("Dynamic link match type: \(dynamicLink.matchType.rawValue)")

            return true
        }

        return false
    }
}

