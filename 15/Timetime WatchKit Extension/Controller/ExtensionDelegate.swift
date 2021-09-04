import ClockKit
import WatchKit
import UserNotifications
import Combine

class ExtensionDelegate: NSObject, WKExtensionDelegate {
    func handleUserActivity(_ userInfo: [AnyHashable : Any]?) {
        if (userInfo?[CLKLaunchedTimelineEntryDateKey] as? Date) != nil {
            print("从表盘来")
        }
        else {
            print("从其他地方来")
        }
    }
    //进入后台
    func applicationDidEnterBackground() {
        scheduleNextReload()
        print("进入后台")
        //scheduleBackgroundRefreshTasks()
    }
    //进入活跃
    func applicationDidBecomeActive() {
        print("进入活跃")
    }
    //开始启动
    func applicationDidFinishLaunching() {
        UNUserNotificationCenter.current().delegate = self
        scheduleNextReload()
        reloadActiveComplications()
        //scheduleBackgroundRefreshTasks()
    }
    func nextReloadTime(after date: Date) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        let targetMinutes = DateComponents(minute: 9)
        var nextReloadTime = calendar.nextDate (
            after: date,
            matching: targetMinutes,
            matchingPolicy: .nextTime
        )!
        // 如果和当前时间间隔小于 5 分钟，那么跳过，尝试下一个小时
        if nextReloadTime.timeIntervalSince (date) < 5 * 60 {
            nextReloadTime.addTimeInterval (3600)
        }
        return nextReloadTime
    }
    func scheduleNextReload() {
        let targetDate = nextReloadTime (after: Date())
        WKExtension.shared ().scheduleBackgroundRefresh (
            withPreferredDate: targetDate,
            userInfo: nil,
            scheduledCompletion: { _ in }
        )
    }
    func reloadActiveComplications() {
        print("重载表盘")
        let server = CLKComplicationServer.sharedInstance()
        for complication in server.activeComplications ?? [] {
            server.reloadTimeline(for: complication)
        }
    }

    func scheduleBackgroundRefreshTasks() {
        let watchExtension = WKExtension.shared()
        let targetDate = Date().addingTimeInterval(15.0 * 60.0)
        watchExtension.scheduleBackgroundRefresh(withPreferredDate: targetDate, userInfo: nil) { (error) in
            if let error = error {
                print("*** An background refresh error occurred: \(error.localizedDescription) ***")
                return
            }
            print("后台刷新点1")
            self.reloadActiveComplications()
            print("后台刷新点2")
            print("*** 后台刷新成功! ***")
        }
    }
    
    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        for task in backgroundTasks {
            switch task {
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                scheduleNextReload()
                reloadActiveComplications()
                //self.scheduleBackgroundRefreshTasks()
                print("后台刷新点3")
                backgroundTask.setTaskCompletedWithSnapshot(false)
            default:
                // make sure to complete unhandled task types
                task.setTaskCompletedWithSnapshot(false)
            }
        }
    }
}

extension ExtensionDelegate: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("进入222222222")
        completionHandler([.badge, .sound])
    }


    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "cycle" {

            
        }
    
    }


    
    
}
//let actionIdentifier = response.actionIdentifier
//   switch actionIdentifier {
//   case UNNotificationDismissActionIdentifier: // Notification was dismissed by user
//    print("取消")
//       completionHandler()
//   case UNNotificationDefaultActionIdentifier: // App was opened from notification
//     print("打开")
//       completionHandler()
//   default:
//    print("默认")
//       completionHandler()
//   }
