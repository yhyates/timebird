//
//  TimetimeApp.swift
//  Timetime WatchKit Extension
//
//  Created by 杨恒一 on 2021/1/29.
//

import SwiftUI
import WatchKit

@main
struct TimetimeApp: App {
    
    @WKExtensionDelegateAdaptor(ExtensionDelegate.self) var delegate

    let context = PersistentContainer.persistentContainer.viewContext
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView().environment(\.managedObjectContext, context)
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
