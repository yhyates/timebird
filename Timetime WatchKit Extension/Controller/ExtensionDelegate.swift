import ClockKit
import WatchKit
import UserNotifications
import Combine

class ExtensionDelegate: NSObject, WKExtensionDelegate {
    func handleUserActivity(_ userInfo: [AnyHashable : Any]?) {
        if (userInfo?[CLKLaunchedTimelineEntryDateKey] as? Date) != nil {

        }
        else {
            
        }
    }
    //进入后台
    func applicationDidEnterBackground() {
        scheduleNextReload()
        //scheduleBackgroundRefreshTasks()
    }
    //进入活跃
    func applicationDidBecomeActive() {

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
        completionHandler([.badge, .sound])
        WKInterfaceDevice.current().play(.success)

    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        //WKInterfaceDevice.current().play(.notification)
        completionHandler()
    }

}
//时间间隔法
//            //循环转换
//            var dateFormatter_all: DateFormatter {
//                let formatter = DateFormatter()
//                //formatter.dateStyle = .short
//                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
//                //formatter.locale = Locale(identifier: "zh_CN")
//                formatter.timeZone = TimeZone(abbreviation: "GMT+8")
//                return formatter
//            }
//            var saved_year: String {
//                UserDefaults.standard.string(forKey: "refreshdate") ?? "\(Date())"
//            }
//            let cc = "\(String(describing: saved_year))"
//            let dd = dateFormatter_all.date(from: cc)
//            let startdata = dd ?? Date()
//            let unit : Calendar.Component = .minute
//            let endd = Calendar.current.ordinality(of: unit, in: .era, for: Date())
//            let startt = Calendar.current.ordinality(of: unit, in: .era, for: startdata)
//            if (endd! - startt!) > 60 {
//                let server = CLKComplicationServer.sharedInstance()
//                for complication in server.activeComplications ?? [] {
//                    server.reloadTimeline(for: complication)
//                }
//                UserDefaults.standard.set("\(Date())", forKey: "refreshdate")
//            }
