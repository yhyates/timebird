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
//        let content = UNMutableNotificationContent()
//        content.title = "进入后台！"
//        content.sound = UNNotificationSound.defaultCritical
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(1), repeats: false)
//        let request = UNNotificationRequest(identifier: "cycle", content: content, trigger: trigger)
//        UNUserNotificationCenter.current().add(request)
        print("进入后台")
        //scheduleBackgroundRefreshTasks()
    }
    
  
    //进入活跃
    func applicationDidBecomeActive() {
        print("进入活跃")


    }
    //开始启动
    func applicationDidFinishLaunching() {
        // Perform any final initialization of your application.
        print("启动节点1")
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

