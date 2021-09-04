//
//  calender.swift
//  Timetime WatchKit Extension
//
//  Created by 杨恒一 on 2021/2/23.
//

import Foundation
import SwiftUI

public struct LunarCalendar : View{
    @Environment(\.calendar) var calendar
    @Environment(\.presentationMode) var mode
    
    private var year: DateInterval {
        calendar.dateInterval(of: .year, for: Date())!
    }
    
    private let onSelect: (Date) -> Void
    
    public init(select: @escaping (Date) -> Void) {
      self.onSelect = select
    }
    
    public var body: some View {
        
        VStack(alignment: .center, spacing: 0, content: {
            CalendarWeek()
                .frame(height: 20.0)
            
            CalendarGrid(interval: year) { date in
                
                CalenderDay(day: Tool.getDay(date: date),
                            lunar: Tool.getInfo(date: date),
                            isToday: calendar.isDateInToday(date),
                            isWeekDay: Tool.isWeekDay(date: date))
//                    .onTapGesture {
//                        mode.wrappedValue.dismiss()
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                            self.onSelect(date)
//                        }
//                    }
            }
        })
        //.padding([.leading, .trailing], 10.0)
        
    }
}


struct Tool {
    
    static func getWeek(week: Int) -> String{
        switch week {
        case 1:
            return "一"
        case 2:
            return "二"
        case 3:
            return "三"
        case 4:
            return "四"
        case 5:
            return "五"
        case 6:
            return "六"
        case 7:
            return "日"
        default:
            return ""
        }
    }
    
    static let chineseHoliDay:[String:String] = ["1-1":"春节",
                                                 "1-15":"元宵节",
                                                 "2-2":"龙抬头",
                                                 "5-5":"端午",
                                                 "7-7":"七夕",
                                                 "7-15":"中元",
                                                 "8-15":"中秋",
                                                 "9-9":"重阳",
                                                 "12-8":"腊八",
                                                 "12-23":"北小年",
                                                 "12-24":"南小年",
                                                 "12-30":"除夕"]
    
    static let gregorianHoliDay:[String:String] = ["1-1":"元旦",
                                                   "2-14":"情人节",
                                                   "3-8":"妇女节",
                                                   "3-12":"植树节",
                                                   "4-1":"愚人节",
                                                   "4-4":"清明",
                                                   "5-1":"劳动节",
                                                   "5-4":"青年节",
                                                   "6-1":"儿童节",
                                                   "7-1":"建党节",
                                                   "8-1":"建军节",
                                                   "10-1":"国庆",
                                                   "12-24":"平安夜",
                                                   "12-25":"圣诞节"]
    
    ///得到今天日期
    static func getDay(date: Date) -> String{
        return String(Calendar.current.component(.day, from: date))
    }
    
    ///获取农历, 节假日名
    static func getInfo(date: Date) -> String{
        //初始化农历日历
        let lunarCalendar = Calendar.init(identifier: .chinese)
        
        ///获得农历月
        let lunarMonth = DateFormatter()
        lunarMonth.locale = Locale(identifier: "zh_CN")
        lunarMonth.dateStyle = .medium
        lunarMonth.calendar = lunarCalendar
        lunarMonth.dateFormat = "MMM"
        
        let month = lunarMonth.string(from: date)
        
        //获得农历日
        let lunarDay = DateFormatter()
        lunarDay.locale = Locale(identifier: "zh_CN")
        lunarDay.dateStyle = .medium
        lunarDay.calendar = lunarCalendar
        lunarDay.dateFormat = "d"
        
        let day = lunarDay.string(from: date)
        ///生成公历日历的Key 用于查询字典
        let gregorianFormatter = DateFormatter()
        gregorianFormatter.locale = Locale(identifier: "zh_CN")
        gregorianFormatter.dateFormat = "M-d"
        
        let gregorian = gregorianFormatter.string(from: date)
        
        ///生成农历的key
        let lunarFormatter = DateFormatter()
        lunarFormatter.locale = Locale(identifier: "zh_CN")
        lunarFormatter.dateStyle = .short
        lunarFormatter.calendar = lunarCalendar
        lunarFormatter.dateFormat = "M-d"
        
        let lunar = lunarFormatter.string(from: date)
        
        ///如果是节假日返回节假日名称
        if let holiday = getHoliday(lunarKey: lunar, gregorKey: gregorian) {
            return holiday
        }
        
        //返回农历月
        if day == "初一" {
            return month
        }
        
        //返回农历日期
        return day
        
    }
    
    static func getHoliday(lunarKey: String, gregorKey: String) -> String?{
        
        ///当前农历节日优先返回
        if let holiday = chineseHoliDay[lunarKey]{
            return holiday
        }
        
        ///当前公历历节日返回
        if let holiday = gregorianHoliDay[gregorKey]{
            return holiday
        }
        
        return nil
    }
    
    static func isWeekDay(date: Date) -> Bool{
        switch date.getWeekDay() {
        case 7, 1:
            return true
        default:
            return false
        }
    }
}

struct CalenderDay: View {
    
    let day: String
    let lunar: String
    let isToday: Bool
    let isWeekDay: Bool
    
    var body: some View {
        ZStack{
            VStack{
                
                Text(day)
               
                    .padding(.horizontal, 1.0)
                    .foregroundColor(isWeekDay ? Color("cutepurple") : Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5).stroke( isToday ? Color.yellow : Color.clear, lineWidth: 1)
                    )
                Text(lunar)
                    //.font(.footnote)
                    .font(.system(size:9.5))
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: true, vertical: false)
                    .foregroundColor(isWeekDay ? Color("cutepurple") : Color.gray)
            }
           // .padding(.bottom, 5.0)
       

        }
        
    }
    
}


public struct CalendarWeek: View {
    public var body: some View {
        HStack{
            ForEach(1...7, id: \.self) { count in
                Text(Tool.getWeek(week: count))
                    .font(.footnote)
                    .foregroundColor(Color("cuteyellow2"))
                    .frame(maxWidth: .infinity)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}

public struct CalendarGrid<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar
    
    let interval: DateInterval
    let showHeaders: Bool
    let content: (Date) -> DateView
    
    public init(interval: DateInterval, showHeaders: Bool = true, @ViewBuilder content: @escaping (Date) -> DateView) {
        self.interval = interval
        self.showHeaders = showHeaders
        self.content = content
    }
    let formatter = DateFormatter.monthAndYear
 
    public var body: some View {
        ///添加到可以滚动
        ScrollView(.vertical, showsIndicators: false){
            ///添加滚动监听
            ScrollViewReader { (proxy: ScrollViewProxy) in
                ///生成网格
                LazyVGrid(columns: Array(repeating: GridItem(spacing: 1, alignment: .center), count: 7)) {
                    ///枚举每个月
                    ForEach(months, id: \.self) { month in
                        ///以每月为一个Section,添加月份
                        Section(header: header(for: month)) {
                            ForEach(days(for: month), id: \.self) { date in
                                if calendar.isDate(date, equalTo: month, toGranularity: .month) {
                                    content(date).id(date)

                                } else {
                                    content(date).hidden()
                                }

                            }
                        }//section

                        .id(sectionID(for: month))///给每个月创建ID,方便进行滚动标记

                    }//foreach
                }//grid

                .onAppear(){
                    ///当View展示的时候直接滚动到标记好的月份
                    proxy.scrollTo(scroolSectionID() )
                }

            }

        }

    }
    ///获取当前是几月,并进行滚动到那里
    private func scroolSectionID() -> Int {
        let component = calendar.component(.month, from: Date())
        return component
    }
    ///根据月份生成SectionID
    private func sectionID(for month: Date) -> Int {
        let component = calendar.component(.month, from: month)
        return component
    }
    ///获得年间距的月份日期的第一天,生成数组
    private var months: [Date] {
        calendar.generateDates(
            inside: interval,
            matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0)
        )
    }
    ///创建一个简单的SectionHeader
    private func header(for month: Date) -> some View {
        let formatter = DateFormatter.monthAndYear
        
        return Group {
            if showHeaders {
                Divider()
                .navigationBarTitle("\(formatter.string(from: month))")
                
            }
        }
    }
    ///获取每个月,网格范围内的起始结束日期数组
    private func days(for month: Date) -> [Date] {
        ///重点讲解
        ///先拿到月份间距,例如1号--31号
        guard let monthInterval = calendar.dateInterval(of: .month, for: month) else { return [] }
        ///先获取第一天所在周的周一到周日
        let monthFirstWeek = monthInterval.start.getWeekStartAndEnd()
        ///获取月最后一天所在周的周一到周日
        let monthLastWeek = monthInterval.end.getWeekStartAndEnd()
        ///然后根据月初所在周的周一为0号row 到月末所在周的周日为最后一个row生成数组
        return calendar.generateDates(
            inside: DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end),
            matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }
    
}




extension Date {
    
    func getWeekDay() -> Int{
        let calendar = Calendar.current
        ///拿到现在的week数字
        let components = calendar.dateComponents([.weekday], from: self)
        return components.weekday!
    }
    
    ///获取当前Date所在周的周一到周日
    func getWeekStartAndEnd() -> DateInterval{
        var date = self
        ///因为一周的起始日是周日,周日已经算是下一周了
        ///如果是周日就到退回去两天
        if date.getWeekDay() == 1 {
            date = date.addingTimeInterval(-60 * 60 * 24 * 2)
        }
        ///使用处理后的日期拿到这一周的间距: 周日到周六
        let week = Calendar.current.dateInterval(of: .weekOfMonth, for: date)!
        ///处理一下周日加一天到周一
        let monday = week.start.addingTimeInterval(60 * 60 * 24)
        ///周六加一天到周日
        let sunday = week.end.addingTimeInterval(60 * 60 * 24)
        ///生成新的周一到周日的间距
        let interval = DateInterval(start: monday, end: sunday)
        return interval
    }
}

extension DateFormatter {
    
    static var month: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "M月"
        return formatter
    }
    
    static var monthAndYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年M月"
        return formatter
    }
}

extension Calendar {
    func generateDates(inside interval: DateInterval, matching components: DateComponents) -> [Date] {
        var dates: [Date] = []
        
        dates.append(interval.start)
        
        enumerateDates(startingAfter: interval.start, matching: components, matchingPolicy: .nextTime) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }
        return dates
    }
}
