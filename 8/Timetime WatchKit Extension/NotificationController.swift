//
//  NotificationController.swift
//  Timetime WatchKit Extension
//
//  Created by 杨恒一 on 2021/1/29.
//

import WatchKit
import SwiftUI
import UserNotifications
//import ClockKit

class NotificationController: WKUserNotificationHostingController<NotificationView> {

    
    override var body: NotificationView {
        return NotificationView()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        print("我在这里3")

    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        print("我在这里2")

    }

    override func didReceive(_ notification: UNNotification) {
//        var countcycle = ["1", "3", "5", "10", "15", "20", "25", "30", "45", "60", "90"]
//        let saveddata = UserDefaults.standard.string(forKey: "\(yeardayfresh())")
//        let today_data:Double? = Double("\(saveddata ?? "0.0")")//double型旧数据
//        let stringcycle = UserDefaults.standard.string(forKey: "cycle")
//        let cc = "\(stringcycle ?? "1")"
//        let dd:Int? = Int(cc)!-1
//        let cycleselceted = Double(String(countcycle[dd!]))
//        let intcycle = cycleselceted!//double型cycle
//        UserDefaults.standard.set(String(today_data!+intcycle), forKey: "\(yeardayfresh())")
        print("我在这里")
    }
    
    
    
}
