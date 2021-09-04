//
//  func.swift
//  Timetime WatchKit Extension
//
//  Created by 杨恒一 on 2021/4/13.
//
import SwiftUI
import Foundation
import UserNotifications
import LunarCore

func sematicStyle() -> ChartStyle {
    let style = Styles.barChartStyleNeonBlueDark
    style.darkModeStyle = Styles.barChartStyleNeonBlueDark
    return style
}

func deviceui() -> Float {
    if WKInterfaceDevice.current().screenBounds.size.width == 156.0 {
        return 54.0
    } else if WKInterfaceDevice.current().screenBounds.size.width == 184.0 {
        return 57.5
    } else if WKInterfaceDevice.current().screenBounds.size.width == 162.0 {
        return 55.0
    } else {
        return 55.0
    }
}

func get_data() {
    let saved_year = UserDefaults.standard.string(forKey: "year")
    if saved_year != nil {}
    else{
        UserDefaults.standard.set("30", forKey: "year")
    }
    let saved_month = UserDefaults.standard.string(forKey: "month")
    if saved_month != nil {}
    else{
        UserDefaults.standard.set("6", forKey: "month")
    }
    let saved_day = UserDefaults.standard.string(forKey: "day")
    if saved_day != nil {}
    else{
        UserDefaults.standard.set("15", forKey: "day")
    }
    let saved_cycle = UserDefaults.standard.string(forKey: "cycle")
    if saved_cycle != nil {}
    else{
        UserDefaults.standard.set("7", forKey: "cycle")
    }
    let saved_cyclerun = UserDefaults.standard.string(forKey: "cyclerun")
    if saved_cyclerun != nil {}
    else{
        UserDefaults.standard.set("false", forKey: "cyclerun")
    }
    
    let todaydataa = UserDefaults.standard.string(forKey: "\(yeardayfresh())")
    if todaydataa != nil {}
    else{
        UserDefaults.standard.set("0.0", forKey: "\(yeardayfresh())")
    }
    let beforedataa1 = UserDefaults.standard.string(forKey: "\(yeardayfresh()-1)")
    if beforedataa1 != nil {}
    else{
        UserDefaults.standard.set("0.0", forKey: "\(yeardayfresh()-1)")
    }
    let beforedataa2 = UserDefaults.standard.string(forKey: "\(yeardayfresh()-2)")
    if beforedataa2 != nil {}
    else{
        UserDefaults.standard.set("0.0", forKey: "\(yeardayfresh()-2)")
    }
    let beforedataa3 = UserDefaults.standard.string(forKey: "\(yeardayfresh()-3)")
    if beforedataa3 != nil {}
    else{
        UserDefaults.standard.set("0.0", forKey: "\(yeardayfresh()-3)")
    }
    let beforedataa4 = UserDefaults.standard.string(forKey: "\(yeardayfresh()-4)")
    if beforedataa4 != nil {}
    else{
        UserDefaults.standard.set("0.0", forKey: "\(yeardayfresh()-4)")
    }
    let beforedataa5 = UserDefaults.standard.string(forKey: "\(yeardayfresh()-5)")
    if beforedataa5 != nil {}
    else{
        UserDefaults.standard.set("0.0", forKey: "\(yeardayfresh()-5)")
    }
    let beforedataa6 = UserDefaults.standard.string(forKey: "\(yeardayfresh()-6)")
    if beforedataa6 != nil {}
    else{
        UserDefaults.standard.set("0.0", forKey: "\(yeardayfresh()-6)")
    }
    let startdataa = UserDefaults.standard.string(forKey: "start")
    if startdataa != nil {}
    else{
        UserDefaults.standard.set("\(Date())", forKey: "start")
    }
    
}
func weekbug(day: Int, hour: Int) -> Float {
    if day == 1
    {
        return Float(Double(144+hour)/168.0*100.0)
    }
    else {
        return Float((Double((day-2)*24+hour))/168*100)
    }
}
func monthbug(year: Int, month: Int, day: Int, hour: Int) -> Float {
    if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12)
    {
        //31days
        return Float(Double((day-1)*24+hour)/744*100)
    }
    else if (month == 4 || month == 6 || month == 9 || month == 11)
    {
        //30days
        return Float(Double((day-1)*24+hour)/720*100)
    }
    else if month == 2
    {
        if (year%4 == 0 && year%100 != 0 || year%400 == 0)
        {
            //29日期Picker
            return Float(Double((day-1)*24+hour)/696*100)
        }
        else
        {
            //28日期Picker
            return Float(Double((day-1)*24+hour)/672*100)
        }
    }
    else {
        return 0.0
    }
}
func yearbug(year: Int, day: Int, hour: Int) -> Float {
    if (year%4 == 0 && year%100 != 0 || year%400 == 0)
    {
        //366days
        return Float(Double((day-1)*24+hour)/8784*100)
    }
    else {
        //365days
        return Float(Double((day-1)*24+hour)/8760*100)
    }
}
func weekfresh() -> Int {
    //该周的第几个星期,默认以周一为界
    var dateFormatter_weekened: DateFormatter {
        let formatter = DateFormatter()
        //formatter.dateStyle = .short
        formatter.dateFormat = "c"//e为周天
        return formatter
    }
    let dayofweek = dateFormatter_weekened.string(from: Date())
    let intdayofweek:Int? = Int(dayofweek)
    let int_dayofweek = intdayofweek!//int型已过天数,默认周天是第一天
    return int_dayofweek
}
func hourfresh() -> Int {
    //一天中的第几个小时,1-24范围
    var dateFormatter_hour: DateFormatter {
        let formatter = DateFormatter()
        //formatter.dateStyle = .short
        formatter.dateFormat = "k"
        return formatter
    }
    let dayofhour = dateFormatter_hour.string(from: Date())
    let intdayofhour:Int? = Int(dayofhour)
    let int_dayofhour = intdayofhour!//int型已过小时,1-24
    return int_dayofhour
}
func weekofyearfresh() -> Int {
    //年份，如2021
    var dateFormatter_year: DateFormatter {
        let formatter = DateFormatter()
        //formatter.dateStyle = .short
        formatter.dateFormat = "ww"
        return formatter
    }
    let todayyear = dateFormatter_year.string(from: Date())
    let inttodayyear:Int? = Int(todayyear)
    let int_todayyear = inttodayyear!//int型本年份
    return int_todayyear
}
func weekofmonthfresh() -> Int {
    //年份，如2021
    var dateFormatter_year: DateFormatter {
        let formatter = DateFormatter()
        //formatter.dateStyle = .short
        formatter.dateFormat = "W"
        return formatter
    }
    let todayyear = dateFormatter_year.string(from: Date())
    let inttodayyear:Int? = Int(todayyear)
    let int_todayyear = inttodayyear!//int型本年份
    return int_todayyear
}
func yearfresh() -> Int {
    //年份，如2021
    var dateFormatter_year: DateFormatter {
        let formatter = DateFormatter()
        //formatter.dateStyle = .short
        formatter.dateFormat = "yyyy"
        return formatter
    }
    let todayyear = dateFormatter_year.string(from: Date())
    let inttodayyear:Int? = Int(todayyear)
    let int_todayyear = inttodayyear!//int型本年份
    return int_todayyear
}
func monthfresh() -> Int {
    //月份，如12
    var dateFormatter_month: DateFormatter {
        let formatter = DateFormatter()
        //formatter.dateStyle = .short
        formatter.dateFormat = "MM"
        return formatter
    }
    let todaymonth = dateFormatter_month.string(from: Date())
    let inttodaymonth:Int? = Int(todaymonth)
    let int_todaymonth = inttodaymonth!//int型本月份
    return int_todaymonth
}

func monthdayfresh() -> Int {
    //该月中的第几天，如2/31
    var dateFormatter_daymonth: DateFormatter {
        let formatter = DateFormatter()
        //formatter.dateStyle = .short
        formatter.dateFormat = "dd"
        return formatter
    }
    let dayofmonth = dateFormatter_daymonth.string(from: Date())
    let intdayofmonth:Int? = Int(dayofmonth)
    let int_dayofmonth = intdayofmonth!//int型已过天数
    return int_dayofmonth
}
func yeardayfresh() -> Int {
    //该年中的第几天，如128/365
    var dateFormatter_day: DateFormatter {
        let formatter = DateFormatter()
        //formatter.dateStyle = .short
        formatter.dateFormat = "DDD"
        return formatter
    }
    let dayofyear = dateFormatter_day.string(from: Date())
    let intdayofyear:Int? = Int(dayofyear)
    let int_dayofyear = intdayofyear!//int型已过天数
    return int_dayofyear
}
func newyearbug(beforedate: Int) -> Double {
    let stringbeforedate = UserDefaults.standard.string(forKey: "\(beforedate)")
    let stringbefore_date:Double? = Double("\(stringbeforedate ?? "0.0")")
    return stringbefore_date!
}

func requestNotificationPermissions() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { allow, error in
        guard allow else {
            return
        }
    }
}
func moon() -> String{
let lunar_moonpic = [
    "初一":"🌑",
    "初二":"🌑",
    "初三":"🌒",
    "初四":"🌒",
    "初五":"🌓",
    "初六":"🌓",
    "初七":"🌓",
    "初八":"🌓",
    "初九":"🌓",
    "初十":"🌔",
    "十一":"🌔",
    "十二":"🌔",
    "十三":"🌕",
    "十四":"🌕",
    "十五":"🌕",
    "十六":"🌕",
    "十七":"🌖",
    "十八":"🌖",
    "十九":"🌖",
    "二十":"🌖",
    "廿一":"🌗",
    "廿二":"🌗",
    "廿三":"🌘",
    "廿四":"🌘",
    "廿五":"🌘",
    "廿六":"🌘",
    "廿七":"🌑",
    "廿八":"🌑",
    "廿九":"🌑",
    "三十":"🌑",
    
]
    let lunarday = "\(LunarCore.solarToLunar(yearfresh(), monthfresh(), monthdayfresh())["lunarDayName"]!)" as String
    return lunar_moonpic[lunarday]!
}
func lunar() -> String{
    let lunar_12 = [
        1:"丑",
        2:"丑",
        3:"寅",
        4:"寅",
        5:"卯",
        6:"卯",
        7:"辰",
        8:"辰",
        9:"巳",
        10:"巳",
        11:"午",
        12:"午",
        13:"未",
        14:"未",
        15:"申",
        16:"申",
        17:"酉",
        18:"酉",
        19:"戌",
        20:"戌",
        21:"亥",
        22:"亥",
        23:"子",
        0:"子",
    ]
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "zh_CN")
    formatter.dateStyle = .full
    formatter.calendar = Calendar.init(identifier: .chinese)
    let lunarstring1 = formatter.string(from: Date())
    let lunainfo : String = "\(lunarstring1)"
    let lunadata = lunainfo[4..<11]+"周"+lunainfo[13..<14]+lunar_12[Calendar.current.component(.hour, from: Date())]!+"时"
    return lunadata
}
