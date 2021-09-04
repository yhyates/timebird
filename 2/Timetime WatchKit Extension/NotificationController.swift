//
//  NotificationController.swift
//  Timetime WatchKit Extension
//
//  Created by 杨恒一 on 2021/1/29.
//

import WatchKit
import SwiftUI
import UserNotifications
import ClockKit

class NotificationController: WKUserNotificationHostingController<NotificationView> {

    override var body: NotificationView {
        return NotificationView()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    override func didReceive(_ notification: UNNotification) {
        // This method is called when a notification needs to be presented.
        // Implement it if you use a dynamic notification interface.
        // Populate your dynamic notification interface as quickly as possible.
        
        
//        //更新表盘
//        let server = CLKComplicationServer.sharedInstance()
//        for complication in server.activeComplications ?? [] {
//            server.reloadTimeline(for: complication)
//        }
        
        
    }
}
