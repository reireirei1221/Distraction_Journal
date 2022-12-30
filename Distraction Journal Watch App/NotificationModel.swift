//
//  Class.swift
//  Distraction Journal Watch App
//
//  Created by 澤野令 on 2022/12/26.
//

// import Foundation
import WatchKit
import UserNotifications

// 通知の実装
class NotificationModel: NSObject, ObservableObject {
    
    struct Category {
        static let tutorial = "tutorial"
    }
    
    // 通知に出てくる選択肢の設定
    struct Action {
        static let Yes = "Yes"
        static let No = "No"
        // static let unsubscribe = "unsubscribe"
    }
    
    // よくわかってないけど, 通知に対するレスポンスをとるためのコード
    var notificationDelegate = ForegroundNotificationDelegate()
        
    override init() {
        UNUserNotificationCenter.current().delegate = self.notificationDelegate
    }
    
    
    // 通知の設定
    func sendNotificationRequest(){
        // Configure the notification's payload.
        let content = UNMutableNotificationContent()
//        content.title = NSString.localizedUserNotificationString(forKey: "Distraction", arguments: nil)
//        content.body = NSString.localizedUserNotificationString(forKey: "Are you still working?", arguments: nil)
//        content.sound = UNNotificationSound.default

        // Deliver the notification in five seconds.
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//        let request = UNNotificationRequest(identifier: "FiveSecond", content: content, trigger: trigger) // Schedule the notification.
        let center = UNUserNotificationCenter.current()
        
        // Define Actions
        let actionYes = UNNotificationAction(identifier: NotificationModel.Action.Yes, title: "Yes", options: [])
        let actionNo = UNNotificationAction(identifier: NotificationModel.Action.No, title: "No", options: [.foreground])
        // let actionUnsubscribe = UNNotificationAction(identifier: NotificationModel.Action.unsubscribe, title: "Unsubscribe", options: [.destructive, .authenticationRequired])

       // Define Category
        //let tutorialCategory = UNNotificationCategory(identifier: Notification.Category.tutorial, actions: [actionYes, actionNo, actionUnsubscribe], intentIdentifiers: [], options: [])
        
        let tutorialCategory = UNNotificationCategory(identifier: NotificationModel.Category.tutorial, actions: [actionYes, actionNo], intentIdentifiers: [], options: [])

       // Register Category
        center.setNotificationCategories([tutorialCategory])
        content.title = NSString.localizedUserNotificationString(forKey: "Distraction", arguments: nil)
        content.body = "Are you still working?"
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "Notification.Category.tutorial"

        // Set Category Identifier
        content.categoryIdentifier = NotificationModel.Category.tutorial

        // Add Trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        let request = UNNotificationRequest(identifier: "FiveSecond", content: content, trigger: trigger) // Schedule the notification.
        
        center.add(request) { (error : Error?) in
             if let theError = error {
                 // Handle any errors
             }
        }
    }
}

// 通知に対するactionの記述 (フォアグラウンドとバックグラウンド両方に対応)
// 参考URL: https://thwork.net/2021/08/29/swiftui_notification_deeplink/

class ForegroundNotificationDelegate:NSObject, UNUserNotificationCenterDelegate{
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        //completionHandler([.alert, .list, .badge, .sound]) //~iOS13
        completionHandler([.banner, .list, .badge, .sound]) //iOS14~
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
            switch response.actionIdentifier {
            case NotificationModel.Action.Yes:
                print("Yes")
            //case Notification.Action.unsubscribe:
            //    print("Show details")
            default:
                print("No")
            }
            completionHandler()
        }
    }

