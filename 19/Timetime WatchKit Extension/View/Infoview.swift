//
//  Infoview.swift
//  Timetime WatchKit Extension
//
//  Created by 杨恒一 on 2021/3/16.
//

import Foundation
import SwiftUI
struct info: View {
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading){

                Text("⚠️【组件错位或显示不全】在 设置-显示与亮度-文字大小中设置动态文本大小：44mm表盘建议设置大小为4级；40mm表盘建议设置大小为3级；42mm表盘建议设置大小为2级。")
                    .font(.footnote)
                    .foregroundColor(Color.gray)
                    .padding(.vertical)
                
                Text("😝【切换视图】手指左右滑动屏幕最下方弧度区域体验最佳。")
                    .font(.footnote)
                    .foregroundColor(Color.gray)
                    .padding(.vertical)
                
                Text("0⃣️【年龄记录】输入 公历 年月日数据，自动计算来到世界多少天，选择自己或者更重要的人，记录她的年华。")
                    .font(.footnote)
                    .foregroundColor(Color.gray)
                    .padding(.bottom)
                Text("1⃣️【时间百分比】精度到小时，自动更新。")
                    .font(.footnote)
                    .foregroundColor(Color.gray)
                    .padding(.bottom)
                Text("2⃣️【循环通知】根据设定时间间隔循环提醒，可用作番茄钟，感知时间流（如演讲控时）和定时提醒（如宝宝进食时间）等功能，时间单位为分钟；记录近七天数据；本功能无需常驻后台，但由于系统机制，应用出于前台模式，不会发送通知长提醒，仅短触感通知，因此使用本功能，尽量切换为后台模式。")
                    .font(.footnote)
                    .foregroundColor(Color.gray)
                    .padding(.bottom)
                Text("3⃣️【Todo清单】支持计数，长按✔︎可累加计数，点按则完成本任务。")
                    .font(.footnote)
                    .foregroundColor(Color.gray)
                    .padding(.bottom)
                Text("4⃣️【记录时间点】一般记录如生日，纪念日，待办等节点；长按拖动可调整顺序，左滑可删除；支持农历，利用时间选择器输入 公历 数据，将自动计算对应本年的农历日期，并显示农历公历倒计时；自动注册动态通知提醒，包括前3天，前天以及当天提醒，通知具体时间为上午8:30-9:30。")
                    .font(.footnote)
                    .foregroundColor(Color.gray)
                    .padding(.bottom)
                Text("5⃣️【复杂功能】后台每小时安排一次刷新；后台运行和启动时鸟会自动刷新表盘，但仍限制每小时刷新一次。")
                    .font(.footnote)
                    .foregroundColor(Color.gray)
                    .padding(.bottom)
            }
        }
        .navigationBarTitle("🧐秘籍")

    }
}
