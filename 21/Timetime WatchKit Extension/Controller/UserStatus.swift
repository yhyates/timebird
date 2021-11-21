//
//  UserStatus.swift
//  Timetime WatchKit Extension
//
//  Created by 杨恒一 on 2021/11/21.
//

import Foundation

class UserStatus: ObservableObject {

    enum Page {
        case timer
        case list
    }

    @Published var currentPage: Page = .timer
}
