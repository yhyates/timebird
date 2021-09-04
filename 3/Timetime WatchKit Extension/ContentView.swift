//
//  TimetimeApp.swift
//  Timetime WatchKit Extension
//
//  Created by 杨恒一 on 2021/1/29.
//

import SwiftUI
import Foundation
import UserNotifications
import ClockKit
import CoreData
import Combine
import SwiftUICharts

//
//func convert(year2: Int, month2: Int, day2: Int) -> (Int, Int, Int){
//    let lunar_month_days = [
//
//        1887, 0x1694, 0x16aa, 0x4ad5, 0xab6, 0xc4b7, 0x4ae, 0xa56, 0xb52a, 0x1d2a,
//
//        0xd54, 0x75aa, 0x156a, 0x1096d, 0x95c, 0x14ae, 0xaa4d, 0x1a4c, 0x1b2a,
//
//        0x8d55, 0xad4, 0x135a, 0x495d, 0x95c, 0xd49b, 0x149a, 0x1a4a, 0xbaa5, 0x16a8,
//
//        0x1ad4, 0x52da, 0x12b6, 0xe937, 0x92e, 0x1496, 0xb64b, 0xd4a, 0xda8, 0x95b5,
//
//        0x56c, 0x12ae, 0x492f, 0x92e, 0xcc96, 0x1a94, 0x1d4a, 0xada9, 0xb5a, 0x56c,
//
//        0x726e, 0x125c, 0xf92d, 0x192a, 0x1a94, 0xdb4a, 0x16aa, 0xad4, 0x955b,
//
//        0x4ba, 0x125a, 0x592b, 0x152a, 0xf695, 0xd94, 0x16aa, 0xaab5, 0x9b4, 0x14b6,
//
//        0x6a57, 0xa56, 0x1152a, 0x1d2a, 0xd54, 0xd5aa, 0x156a, 0x96c, 0x94ae, 0x14ae,
//
//        0xa4c, 0x7d26, 0x1b2a, 0xeb55, 0xad4, 0x12da, 0xa95d, 0x95a, 0x149a, 0x9a4d,
//
//        0x1a4a, 0x11aa5, 0x16a8, 0x16d4, 0xd2da, 0x12b6, 0x936, 0x9497, 0x1496,
//
//        0x1564b, 0xd4a, 0xda8, 0xd5b4, 0x156c, 0x12ae, 0xa92f, 0x92e, 0xc96, 0x6d4a,
//
//        0x1d4a, 0x10d65, 0xb58, 0x156c, 0xb26d, 0x125c, 0x192c, 0x9a95, 0x1a94,
//
//        0x1b4a, 0x4b55, 0xad4, 0xf55b, 0x4ba, 0x125a, 0xb92b, 0x152a, 0x1694, 0x96aa,
//
//        0x15aa, 0x12ab5, 0x974, 0x14b6, 0xca57, 0xa56, 0x1526, 0x8e95, 0xd54, 0x15aa,
//
//        0x49b5, 0x96c, 0xd4ae, 0x149c, 0x1a4c, 0xbd26, 0x1aa6, 0xb54, 0x6d6a, 0x12da,
//
//        0x1695d,0x95a, 0x149a, 0xda4b, 0x1a4a, 0x1aa4, 0xbb54, 0x16b4, 0xada, 0x495b,
//
//        0x936, 0xf497, 0x1496, 0x154a, 0xb6a5, 0xda4, 0x15b4, 0x6ab6, 0x126e, 0x1092f,
//
//        0x92e, 0xc96, 0xcd4a, 0x1d4a, 0xd64, 0x956c, 0x155c, 0x125c, 0x792e, 0x192c,
//
//        0xfa95, 0x1a94, 0x1b4a, 0xab55, 0xad4, 0x14da, 0x8a5d, 0xa5a, 0x1152b, 0x152a,
//
//        0x1694, 0xd6aa, 0x15aa, 0xab4, 0x94ba, 0x14b6, 0xa56, 0x7527, 0xd26, 0xee53,
//
//        0xd54, 0x15aa, 0xa9b5, 0x96c, 0x14ae, 0x8a4e, 0x1a4c, 0x11d26, 0x1aa4, 0x1b54,
//
//        0xcd6a, 0xada, 0x95c, 0x949d, 0x149a, 0x1a2a, 0x5b25, 0x1aa4, 0xfb52, 0x16b4,
//
//        0xaba, 0xa95b, 0x936, 0x1496, 0x9a4b, 0x154a, 0x136a5, 0xda4, 0x15ac ]
//
//    let solar_1_1 = [
//
//        1887, 0xec04c, 0xec23f, 0xec435, 0xec649, 0xec83e, 0xeca51, 0xecc46, 0xece3a,
//
//        0xed04d, 0xed242, 0xed436, 0xed64a, 0xed83f, 0xeda53, 0xedc48, 0xede3d,
//
//        0xee050, 0xee244, 0xee439, 0xee64d, 0xee842, 0xeea36, 0xeec4a, 0xeee3e,
//
//        0xef052, 0xef246, 0xef43a, 0xef64e, 0xef843, 0xefa37, 0xefc4b, 0xefe41,
//
//        0xf0054, 0xf0248, 0xf043c, 0xf0650, 0xf0845, 0xf0a38, 0xf0c4d, 0xf0e42,
//
//        0xf1037, 0xf124a, 0xf143e, 0xf1651, 0xf1846, 0xf1a3a, 0xf1c4e, 0xf1e44,
//
//        0xf2038, 0xf224b, 0xf243f, 0xf2653, 0xf2848, 0xf2a3b, 0xf2c4f, 0xf2e45,
//
//        0xf3039, 0xf324d, 0xf3442, 0xf3636, 0xf384a, 0xf3a3d, 0xf3c51, 0xf3e46,
//
//        0xf403b, 0xf424e, 0xf4443, 0xf4638, 0xf484c, 0xf4a3f, 0xf4c52, 0xf4e48,
//
//        0xf503c, 0xf524f, 0xf5445, 0xf5639, 0xf584d, 0xf5a42, 0xf5c35, 0xf5e49,
//
//        0xf603e, 0xf6251, 0xf6446, 0xf663b, 0xf684f, 0xf6a43, 0xf6c37, 0xf6e4b,
//
//        0xf703f, 0xf7252, 0xf7447, 0xf763c, 0xf7850, 0xf7a45, 0xf7c39, 0xf7e4d,
//
//        0xf8042, 0xf8254, 0xf8449, 0xf863d, 0xf8851, 0xf8a46, 0xf8c3b, 0xf8e4f,
//
//        0xf9044, 0xf9237, 0xf944a, 0xf963f, 0xf9853, 0xf9a47, 0xf9c3c, 0xf9e50,
//
//        0xfa045, 0xfa238, 0xfa44c, 0xfa641, 0xfa836, 0xfaa49, 0xfac3d, 0xfae52,
//
//        0xfb047, 0xfb23a, 0xfb44e, 0xfb643, 0xfb837, 0xfba4a, 0xfbc3f, 0xfbe53,
//
//        0xfc048, 0xfc23c, 0xfc450, 0xfc645, 0xfc839, 0xfca4c, 0xfcc41, 0xfce36,
//
//        0xfd04a, 0xfd23d, 0xfd451, 0xfd646, 0xfd83a, 0xfda4d, 0xfdc43, 0xfde37,
//
//        0xfe04b, 0xfe23f, 0xfe453, 0xfe648, 0xfe83c, 0xfea4f, 0xfec44, 0xfee38,
//
//        0xff04c, 0xff241, 0xff436, 0xff64a, 0xff83e, 0xffa51, 0xffc46, 0xffe3a,
//
//        0x10004e, 0x100242, 0x100437, 0x10064b, 0x100841, 0x100a53, 0x100c48,
//
//        0x100e3c, 0x10104f, 0x101244, 0x101438, 0x10164c, 0x101842, 0x101a35,
//
//        0x101c49, 0x101e3d, 0x102051, 0x102245, 0x10243a, 0x10264e, 0x102843,
//
//        0x102a37, 0x102c4b, 0x102e3f, 0x103053, 0x103247, 0x10343b, 0x10364f,
//
//        0x103845, 0x103a38, 0x103c4c, 0x103e42, 0x104036, 0x104249, 0x10443d,
//
//        0x104651, 0x104846, 0x104a3a, 0x104c4e, 0x104e43, 0x105038, 0x10524a,
//
//        0x10543e, 0x105652, 0x105847, 0x105a3b, 0x105c4f, 0x105e45, 0x106039,
//
//        0x10624c, 0x106441, 0x106635, 0x106849, 0x106a3d, 0x106c51, 0x106e47,
//
//        0x10703c, 0x10724f, 0x107444, 0x107638, 0x10784c, 0x107a3f, 0x107c53,
//
//        0x107e48 ]
//
//    func GetBitInt(data:Int, length:Int, shift:Int) -> Int {
//        return (data&(((1<<length)-1)<<shift))>>shift
//    }
//    func SolarToInt(year2:Int, month2:Int, day2:Int) -> Int {
//        let m = (month2 + 9) % 12
//        let y = year2 - m / 10
//        return 365 * y + y / 4 - y / 100 + y / 400 + (m * 306 + 5) / 10 + (day2 - 1)
//    }
//    func SolarFromInt(g:Int) -> (Int, Int, Int){
//        var y = (10000*g+14780)/3652425
//        var ddd = g-(365*y+y/4-y/100+y/400)
//        if ddd < 0 {
//            y=y-1
//            ddd = g-(365*y+y/4-y/100+y/400)
//        }
//        let mi = (100*ddd+52)/3060
//        let mm = (mi+2)%12+1
//        y = y+(mi+2)/12
//        let dd = ddd-(mi*306+5)/10+1
//        //return "\(y) \(mm) \(dd)"
//        return (y, mm, dd)
//    }
//    //闰月范围1950-2050，如需要增加，自行增加
//    //也就是说在1950-2050之外的阴历时间计算阳历，你需要自己给闰月。不然闰月计算阳历会出错
//    let leapDic = [1952:5, 1955:3, 1957:8, 1960:6, 1963:4, 1966:3, 1968:7,
//
//                   1971:5, 1974:4, 1976:8, 1979:6, 1982:4, 1984:10, 1987:6,
//
//                   1990:5, 1993:3, 1995:8, 1998:5, 2001:4, 2004:2, 2006:7,
//
//                   2009:5, 2012:4, 2014:9, 2017:6, 2020:4, 2023:2, 2025:6,
//
//                   2028:5, 2031:3, 2033:11, 2036:6, 2039:5, 2042:2, 2044:7,
//
//                   2047:5, 2050:3]
//
//    let days = lunar_month_days[year2-lunar_month_days[0]]
//    let leap = GetBitInt(data: days, length: 4, shift: 13)
//    var offset = 0
//    var loopend = leap
//    //判断是否是闰月
//    var isleap = false
//    if leapDic.keys.contains(year2) {
//        if leapDic[year2] == month2 {
//            isleap = true
//        } else {
//            isleap = false
//        }
//    }
//    if !isleap {
//        if month2 <= leap || leap == 0 {
//            loopend = month2-1
//        } else {
//            loopend = month2
//        }
//    }
//    for i in 0..<loopend {
//        offset += GetBitInt(data: days, length: 1, shift: 12-i) == 1 ? 30 : 29
//    }
//    offset += day2
//    let solar11 = solar_1_1[year2-solar_1_1[0]]
//    let y = GetBitInt(data: solar11, length: 12, shift: 9)
//    let m = GetBitInt(data: solar11, length: 4, shift: 5)
//    let d = GetBitInt(data: solar11, length: 5, shift: 0)
//    let g = SolarToInt(year2: y, month2: m, day2: d)+offset-1
//    return SolarFromInt(g: g)
//}

    
    
    

public class PersistentContainer {
    public static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    private init() {}
    public static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Timetime")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()
    public static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
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
        UserDefaults.standard.set("1", forKey: "cycle")
    }
    let saved_cyclerun = UserDefaults.standard.string(forKey: "cyclerun")
    if saved_cyclerun != nil {}
    else{
        UserDefaults.standard.set("false", forKey: "cyclerun")
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



struct AddTime: View {
    static let DefaultWho = "thing"
    static let Defaulticon = "📎"
    @State var who = ""
    @State var icon = ""
    @State var releaseDate = Date()
    //Picker转换
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        //formatter.dateStyle = .short
        formatter.dateFormat = "yyyy年MM月dd日"
        return formatter
    }
    @State private var selectedYear = 30
    @State private var selectedMonth = 6
    @State private var selectedDay = 1
    var year = ["1950", "1951", "1952", "1953", "1954", "1955", "1956", "1957", "1958", "1959", "1960", "1961", "1962", "1963", "1964", "1965", "1966", "1967", "1968", "1969", "1970", "1971", "1972", "1973", "1974", "1975", "1976", "1977", "1978", "1979", "1980", "1981", "1982", "1983", "1984", "1985", "1986", "1987", "1988", "1989", "1990", "1991", "1992", "1993", "1994", "1995", "1996", "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020", "2021"]
    var month = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    var day = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12","13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24","25", "26", "27", "28", "29", "30", "31"]
    
    let onComplete: (String, String, Date) -> Void
    
    var body: some View {
        NavigationView {
            ScrollView {
                HStack{
                    TextField("📎", text: $icon)
                        .frame(width: 38.0)
                    Spacer()
                    //Separator()
                    TextField("说点什么...", text: $who)
                }
                
                Section {
                    
                    HStack {
                        //年份Picker
                        Picker(selection: $selectedYear, label: Text("年")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.green/*@END_MENU_TOKEN@*/)
                                .cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)) {
                            ForEach(0 ..< year.count) {
                                Text(self.year[$0]).multilineTextAlignment(.center).frame(width: 45.0).tag($0)
                                //设置40宽度使40mm下正常显示
                            }
                        }
                        .foregroundColor(Color.green)
                        .onChange(of: selectedYear, perform: { value in
                            
                            let yearselceted =  Int(String(year[selectedYear]))
                            let intyear = yearselceted!//int型年份
                            let monthselceted =  Int(String(month[selectedMonth]))
                            let intmonth = monthselceted!//int型月份
                            let dayselceted =  Int(String(day[selectedDay]))
                            let intday = dayselceted!//int型日期
                            let str = "\(intyear)年\(intmonth)月\(intday)日"
                            self.releaseDate = dateFormatter.date(from: str)!
                            
                        })
                        
                        //月份Picker
                        Picker(selection: $selectedMonth, label: Text("月")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.green/*@END_MENU_TOKEN@*/)
                                .cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)) {
                            
                            ForEach(0 ..< month.count) {
                                Text(self.month[$0]).tag($0)
                            }
                        }
                        .foregroundColor(Color.green)
                        .onChange(of: selectedMonth, perform: { value in
                            let yearselceted =  Int(String(year[selectedYear]))
                            let intyear = yearselceted!//int型年份
                            let monthselceted =  Int(String(month[selectedMonth]))
                            let intmonth = monthselceted!//int型月份
                            let dayselceted =  Int(String(day[selectedDay]))
                            let intday = dayselceted!//int型日期
                            let str = "\(intyear)年\(intmonth)月\(intday)日"
                            self.releaseDate = dateFormatter.date(from: str)!
                        })
                        
                        
                        let yearselceted =  Int(String(year[selectedYear]))
                        let intyear = yearselceted!//int型年份
                        let monthselceted =  Int(String(month[selectedMonth]))
                        let intmonth = monthselceted!//int型月份
                        
                        //注意且或的逻辑顺序，易错
                        if intmonth == 2
                        {
                            if (intyear%4 == 0 && intyear%100 != 0 || intyear%400 == 0)
                            {
                                //29日期Picker
                                Picker(selection: $selectedDay, label: Text("日")
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.black)
                                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.green/*@END_MENU_TOKEN@*/)
                                        .cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)){
                                    
                                    /*ForEach(0 ..< daytwentynine.count) {
                                     Text(self.daytwentynine[$0]).tag($0)
                                     }*/
                                    Group {
                                        Text("1").tag(0)
                                        Text("2").tag(1)
                                        Text("3").tag(2)
                                        Text("4").tag(3)
                                        Text("5").tag(4)
                                        Text("6").tag(5)
                                        Text("7").tag(6)
                                        Text("8").tag(7)
                                        Text("9").tag(8)
                                        Text("10").tag(9)
                                    }
                                    Group {
                                        Text("11").tag(10)
                                        Text("12").tag(11)
                                        Text("13").tag(12)
                                        Text("14").tag(13)
                                        Text("15").tag(14)
                                        Text("16").tag(15)
                                        Text("17").tag(16)
                                        Text("18").tag(17)
                                        Text("19").tag(18)
                                        Text("20").tag(19)
                                    }
                                    Group {
                                        Text("21").tag(20)
                                        Text("22").tag(21)
                                        Text("23").tag(22)
                                        Text("24").tag(23)
                                        Text("25").tag(24)
                                        Text("26").tag(25)
                                        Text("27").tag(26)
                                        Text("28").tag(27)
                                        Text("29").tag(28)
                                    }
                                }
                                .foregroundColor(Color.green)
                                .onChange(of: selectedDay, perform: { value in
                                    let yearselceted =  Int(String(year[selectedYear]))
                                    let intyear = yearselceted!//int型年份
                                    let monthselceted =  Int(String(month[selectedMonth]))
                                    let intmonth = monthselceted!//int型月份
                                    let dayselceted =  Int(String(day[selectedDay]))
                                    let intday = dayselceted!//int型日期
                                    let str = "\(intyear)年\(intmonth)月\(intday)日"
                                    self.releaseDate = dateFormatter.date(from: str)!
                                    
                                })
                                
                                
                                
                            }
                            else
                            {
                                //28日期Picker
                                Picker(selection: $selectedDay, label: Text("日")
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.black)
                                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.green/*@END_MENU_TOKEN@*/)
                                        .cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)){
                                    
                                    /* ForEach(0 ..< daytwentyeight.count) {
                                     Text(self.daytwentyeight[$0]).tag($0)
                                     }*/
                                    Group {
                                        Text("1").tag(0)
                                        Text("2").tag(1)
                                        Text("3").tag(2)
                                        Text("4").tag(3)
                                        Text("5").tag(4)
                                        Text("6").tag(5)
                                        Text("7").tag(6)
                                        Text("8").tag(7)
                                        Text("9").tag(8)
                                        Text("10").tag(9)
                                        
                                    }
                                    Group {
                                        Text("11").tag(10)
                                        Text("12").tag(11)
                                        Text("13").tag(12)
                                        Text("14").tag(13)
                                        Text("15").tag(14)
                                        Text("16").tag(15)
                                        Text("17").tag(16)
                                        Text("18").tag(17)
                                        Text("19").tag(18)
                                        Text("20").tag(19)
                                    }
                                    Group {
                                        Text("21").tag(20)
                                        Text("22").tag(21)
                                        Text("23").tag(22)
                                        Text("24").tag(23)
                                        Text("25").tag(24)
                                        Text("26").tag(25)
                                        Text("27").tag(26)
                                        Text("28").tag(27)
                                    }
                                }
                                .foregroundColor(Color.green)
                                .onChange(of: selectedDay, perform: { value in
                                    let yearselceted =  Int(String(year[selectedYear]))
                                    let intyear = yearselceted!//int型年份
                                    let monthselceted =  Int(String(month[selectedMonth]))
                                    let intmonth = monthselceted!//int型月份
                                    let dayselceted =  Int(String(day[selectedDay]))
                                    let intday = dayselceted!//int型日期
                                    let str = "\(intyear)年\(intmonth)月\(intday)日"
                                    self.releaseDate = dateFormatter.date(from: str)!
                                    
                                })
                                
                            }
                        }
                        
                        if (intmonth == 4 || intmonth == 6 || intmonth == 9 || intmonth == 11)
                        {
                            //30日期Picker
                            Picker(selection: $selectedDay, label: Text("日")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.black)
                                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.green/*@END_MENU_TOKEN@*/)
                                    .cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)) {
                                
                                /*ForEach(0 ..< daythity.count) {
                                 Text(self.daythity[$0]).tag($0)
                                 }*/
                                Group {
                                    Text("1").tag(0)
                                    Text("2").tag(1)
                                    Text("3").tag(2)
                                    Text("4").tag(3)
                                    Text("5").tag(4)
                                    Text("6").tag(5)
                                    Text("7").tag(6)
                                    Text("8").tag(7)
                                    Text("9").tag(8)
                                    Text("10").tag(9)
                                }
                                Group {
                                    Text("11").tag(10)
                                    Text("12").tag(11)
                                    Text("13").tag(12)
                                    Text("14").tag(13)
                                    Text("15").tag(14)
                                    Text("16").tag(15)
                                    Text("17").tag(16)
                                    Text("18").tag(17)
                                    Text("19").tag(18)
                                    Text("20").tag(19)
                                }
                                Group {
                                    Text("21").tag(20)
                                    Text("22").tag(21)
                                    Text("23").tag(22)
                                    Text("24").tag(23)
                                    Text("25").tag(24)
                                    Text("26").tag(25)
                                    Text("27").tag(26)
                                    Text("28").tag(27)
                                    Text("29").tag(28)
                                    Text("30").tag(29)
                                    
                                }
                            }
                            .foregroundColor(Color.green)
                            .onChange(of: selectedDay, perform: { value in
                                let yearselceted =  Int(String(year[selectedYear]))
                                let intyear = yearselceted!//int型年份
                                let monthselceted =  Int(String(month[selectedMonth]))
                                let intmonth = monthselceted!//int型月份
                                let dayselceted =  Int(String(day[selectedDay]))
                                let intday = dayselceted!//int型日期
                                let str = "\(intyear)年\(intmonth)月\(intday)日"
                                self.releaseDate = dateFormatter.date(from: str)!
                                
                                
                                
                            })
                            
                        }
                        
                        if (intmonth == 1 || intmonth == 3 || intmonth == 5 || intmonth == 7 || intmonth == 8 || intmonth == 10 || intmonth == 12)
                        {
                            //31日期Picker
                            Picker(selection: $selectedDay, label: Text("日")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.black)
                                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.green/*@END_MENU_TOKEN@*/)
                                    .cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)) {
                                
                                /*ForEach(0 ..< daythityone.count) {
                                 Text(self.daythityone[$0]).tag($0)
                                 }*/
                                Group {
                                    Text("1").tag(0)
                                    Text("2").tag(1)
                                    Text("3").tag(2)
                                    Text("4").tag(3)
                                    Text("5").tag(4)
                                    Text("6").tag(5)
                                    Text("7").tag(6)
                                    Text("8").tag(7)
                                    Text("9").tag(8)
                                    Text("10").tag(9)
                                }
                                Group {
                                    Text("11").tag(10)
                                    Text("12").tag(11)
                                    Text("13").tag(12)
                                    Text("14").tag(13)
                                    Text("15").tag(14)
                                    Text("16").tag(15)
                                    Text("17").tag(16)
                                    Text("18").tag(17)
                                    Text("19").tag(18)
                                    Text("20").tag(19)
                                }
                                Group {
                                    Text("21").tag(20)
                                    Text("22").tag(21)
                                    Text("23").tag(22)
                                    Text("24").tag(23)
                                    Text("25").tag(24)
                                    Text("26").tag(25)
                                    Text("27").tag(26)
                                    Text("28").tag(27)
                                    Text("29").tag(28)
                                    Text("30").tag(29)
                                }
                                Group {
                                    Text("31").tag(30)
                                }
                                
                            }
                            .foregroundColor(Color.green)
                            .onChange(of: selectedDay, perform: { value in
                                let yearselceted =  Int(String(year[selectedYear]))
                                let intyear = yearselceted!//int型年份
                                let monthselceted =  Int(String(month[selectedMonth]))
                                let intmonth = monthselceted!//int型月份
                                let dayselceted =  Int(String(day[selectedDay]))
                                let intday = dayselceted!//int型日期
                                let str = "\(intyear)年\(intmonth)月\(intday)日"
                                self.releaseDate = dateFormatter.date(from: str)!
                                
                            })
                            
                        }
                    }
                    .frame(height: 68.0)
                }
                Divider()
                    .padding(.vertical)
                
                Section {
                    Button(action: addMoveAction) {
                        Text("完成")
                    }
                    .foregroundColor(Color.black)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("cutegreen")/*@END_MENU_TOKEN@*/)
                    .cornerRadius(20.0)
                    
                    
                }
            }
        }
    }
    
    private func addMoveAction() {
        onComplete(
            who.isEmpty ? AddTime.DefaultWho : who,
            icon.isEmpty ? AddTime.Defaulticon : icon,
            releaseDate)
        WKInterfaceDevice.current().play(.success)
        
    }
    
}

struct TimeRow: View {
    let movie: Time
    static let releaseFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    var body: some View {
        HStack(alignment: .center) {
            movie.icon.map(Text.init)
                .font(.title3)            
            movie.who.map(Text.init)
                .font(.caption)
                .lineLimit(1)
            //.minimumScaleFactor(0.1)
            Spacer()
            movie.releaseDate.map { Text(Self.releaseFormatter.string(from: $0)) }
                .font(.caption)
                .frame(width: 88.0)
            
            
        }
    }
}




//struct clockk: View {
//    @State var timerVal = 1
//    var body: some View {
//        Text("\(timerVal)")
//            .onAppear(){
//                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
//                        self.timerVal += 1
//                }
//        }
//
//    }
//}


func requestNotificationPermissions() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { allow, error in
        guard allow else {
            return
        }
    }
}


struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: Time.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Time.userOrder, ascending: true),
            NSSortDescriptor(keyPath: \Time.who, ascending: true)
        ]
    ) var times: FetchedResults<Time>
    @State var isPresented = false
    
 
    
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
    
    //Picker转换
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        //formatter.dateStyle = .short
        formatter.dateFormat = "yyyy年MM月dd日"
        return formatter
    }
    //该小时的第几分钟
    var dateFormatter_mins: DateFormatter {
        let formatter = DateFormatter()
        //formatter.dateStyle = .short
        formatter.dateFormat = "m"
        return formatter
    }
    //ceshi
    @State var progressValue: Float = 0.9
    
    var year = ["1960", "1961", "1962", "1963", "1964", "1965", "1966", "1967", "1968", "1969", "1970", "1971", "1972", "1973", "1974", "1975", "1976", "1977", "1978", "1979", "1980", "1981", "1982", "1983", "1984", "1985", "1986", "1987", "1988", "1989", "1990", "1991", "1992", "1993", "1994", "1995", "1996", "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020", "2021"]
    var month = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    var day = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12","13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24","25", "26", "27", "28", "29", "30", "31"]
    var countcycle = ["1", "3", "5", "10", "15", "20", "25", "30", "45", "60", "90"]
    
    @State private var today = Date()
    let stringyear = UserDefaults.standard.string(forKey: "year")
    @State private var selectedYear = 30
    let stringmonth = UserDefaults.standard.string(forKey: "month")
    @State private var selectedMonth = 6
    let stringday = UserDefaults.standard.string(forKey: "day")
    @State private var selectedDay = 1
    let stringcycle = UserDefaults.standard.string(forKey: "cycle")
    @State private var selected_cycle = 1
    
    @State private var isopen = false
    @State private var isopen2 = false

    @State private var stringcyclerun = UserDefaults.standard.string(forKey: "cyclerun")
    
    @State private var showingInfoAlert = false
    
    @State private var lunarrr = ""
    @State private var freshyear = ""
    @State private var freshmonth = ""
    @State private var freshweek = ""
    
    @State private var anima = false

    var repeatingAnimation: Animation {
        Animation.easeInOut(duration: 0.3)
            //.delay(5)
        //.repeatForever()
    }
    var easeAnimation: Animation {
        Animation.easeInOut(duration: 4)
            .speed(3)
           // .repeatForever()

    }
    @State var size: CGFloat = 1.0
    @State private var showbar = false

    var body: some View {
        
        TabView(selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Selection@*/.constant(1)/*@END_MENU_TOKEN@*/) {
            //第一页
            ScrollView {
                HStack {
                    //年份Picker
                    Picker(selection: $selectedYear, label: Text("年")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.green/*@END_MENU_TOKEN@*/)
                            .cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)) {
                        ForEach(0 ..< year.count) {
                            Text(self.year[$0]).multilineTextAlignment(.center).frame(width: 45.0).tag($0)
                            //设置40宽度使40mm下正常显示
                        }
                    }.animation(anima ? nil : Animation.easeInOut(duration: 4).speed(3))
                    .foregroundColor(Color.green)
                    .onChange(of: selectedYear, perform: { value in
                        self.anima = true
                        UserDefaults.standard.set(String(selectedYear+1), forKey: "year")
                    })
                    .onAppear{
                        let cc = "\(stringyear ?? "1")"
                        let dd:Int? = Int(cc)!-1
                        self.selectedYear = dd ?? 0
                    }
                    
                    //月份Picker
                    Picker(selection: $selectedMonth, label: Text("月")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.green/*@END_MENU_TOKEN@*/)
                            .cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)) {
                        
                        ForEach(0 ..< month.count) {
                            Text(self.month[$0]).tag($0)
                        }
                    }
                    .animation(anima ? nil : Animation.easeInOut(duration: 4).speed(2.5))
                    .foregroundColor(Color.green)
                    .onChange(of: selectedMonth, perform: { value in
                        self.anima = true
                        UserDefaults.standard.set(String(selectedMonth+1), forKey: "month")
                    })
                    .onAppear{
                        let cc = "\(stringmonth ?? "1")"
                        let dd:Int? = Int(cc)!-1
                        self.selectedMonth = dd ?? 0
                    }
                    
                    let yearselceted =  Int(String(year[selectedYear]))
                    let intyear = yearselceted!//int型年份
                    let monthselceted =  Int(String(month[selectedMonth]))
                    let intmonth = monthselceted!//int型月份
                    
                    //注意且或的逻辑顺序，易错
                    if intmonth == 2
                    {
                        if (intyear%4 == 0 && intyear%100 != 0 || intyear%400 == 0)
                        {
                            //29日期Picker
                            Picker(selection: $selectedDay, label: Text("日")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.black)
                                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.green/*@END_MENU_TOKEN@*/)
                                    .cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)){
                                Group {
                                    Text("1").tag(0)
                                    Text("2").tag(1)
                                    Text("3").tag(2)
                                    Text("4").tag(3)
                                    Text("5").tag(4)
                                    Text("6").tag(5)
                                    Text("7").tag(6)
                                    Text("8").tag(7)
                                    Text("9").tag(8)
                                    Text("10").tag(9)
                                }
                                Group {
                                    Text("11").tag(10)
                                    Text("12").tag(11)
                                    Text("13").tag(12)
                                    Text("14").tag(13)
                                    Text("15").tag(14)
                                    Text("16").tag(15)
                                    Text("17").tag(16)
                                    Text("18").tag(17)
                                    Text("19").tag(18)
                                    Text("20").tag(19)
                                }
                                Group {
                                    Text("21").tag(20)
                                    Text("22").tag(21)
                                    Text("23").tag(22)
                                    Text("24").tag(23)
                                    Text("25").tag(24)
                                    Text("26").tag(25)
                                    Text("27").tag(26)
                                    Text("28").tag(27)
                                    Text("29").tag(28)
                                }
                            }
                            .animation(anima ? nil : Animation.easeInOut(duration: 4).speed(2))
                            .foregroundColor(Color.green)
                            .onChange(of: selectedDay, perform: { value in
                                self.anima = true
                                UserDefaults.standard.set(String(selectedDay+1), forKey: "day")
                            })
                            .onAppear{
                                let cc = "\(stringday ?? "1")"
                                let dd:Int? = Int(cc)!-1
                                self.selectedDay = dd ?? 0
                            }
                        }
                        else
                        {
                            //28日期Picker
                            Picker(selection: $selectedDay, label: Text("日")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.black)
                                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.green/*@END_MENU_TOKEN@*/)
                                    .cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)){
                                Group {
                                    Text("1").tag(0)
                                    Text("2").tag(1)
                                    Text("3").tag(2)
                                    Text("4").tag(3)
                                    Text("5").tag(4)
                                    Text("6").tag(5)
                                    Text("7").tag(6)
                                    Text("8").tag(7)
                                    Text("9").tag(8)
                                    Text("10").tag(9)
                                    
                                }
                                Group {
                                    Text("11").tag(10)
                                    Text("12").tag(11)
                                    Text("13").tag(12)
                                    Text("14").tag(13)
                                    Text("15").tag(14)
                                    Text("16").tag(15)
                                    Text("17").tag(16)
                                    Text("18").tag(17)
                                    Text("19").tag(18)
                                    Text("20").tag(19)
                                }
                                Group {
                                    Text("21").tag(20)
                                    Text("22").tag(21)
                                    Text("23").tag(22)
                                    Text("24").tag(23)
                                    Text("25").tag(24)
                                    Text("26").tag(25)
                                    Text("27").tag(26)
                                    Text("28").tag(27)
                                }
                            }
                            .animation(anima ? nil : Animation.easeInOut(duration: 4).speed(2))
                            .foregroundColor(Color.green)
                            .onChange(of: selectedDay, perform: { value in
                                self.anima = true
                                UserDefaults.standard.set(String(selectedDay+1), forKey: "day")
                            })
                            .onAppear{
                                let cc = "\(stringday ?? "1")"
                                let dd:Int? = Int(cc)!-1
                                self.selectedDay = dd ?? 0
                            }
                        }
                    }
                    
                    if (intmonth == 4 || intmonth == 6 || intmonth == 9 || intmonth == 11)
                    {
                        //30日期Picker
                        Picker(selection: $selectedDay, label: Text("日")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.green/*@END_MENU_TOKEN@*/)
                                .cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)) {
                            Group {
                                Text("1").tag(0)
                                Text("2").tag(1)
                                Text("3").tag(2)
                                Text("4").tag(3)
                                Text("5").tag(4)
                                Text("6").tag(5)
                                Text("7").tag(6)
                                Text("8").tag(7)
                                Text("9").tag(8)
                                Text("10").tag(9)
                            }
                            Group {
                                Text("11").tag(10)
                                Text("12").tag(11)
                                Text("13").tag(12)
                                Text("14").tag(13)
                                Text("15").tag(14)
                                Text("16").tag(15)
                                Text("17").tag(16)
                                Text("18").tag(17)
                                Text("19").tag(18)
                                Text("20").tag(19)
                            }
                            Group {
                                Text("21").tag(20)
                                Text("22").tag(21)
                                Text("23").tag(22)
                                Text("24").tag(23)
                                Text("25").tag(24)
                                Text("26").tag(25)
                                Text("27").tag(26)
                                Text("28").tag(27)
                                Text("29").tag(28)
                                Text("30").tag(29)
                            }
                        }
                        .animation(anima ? nil : Animation.easeInOut(duration: 4).speed(2))
                        .foregroundColor(Color.green)
                        .onChange(of: selectedDay, perform: { value in
                            self.anima = true
                            UserDefaults.standard.set(String(selectedDay+1), forKey: "day")
                        })
                        .onAppear{
                            let cc = "\(stringday ?? "1")"
                            let dd:Int? = Int(cc)!-1
                            self.selectedDay = dd ?? 0
                        }
                    }
                    
                    if (intmonth == 1 || intmonth == 3 || intmonth == 5 || intmonth == 7 || intmonth == 8 || intmonth == 10 || intmonth == 12)
                    {
                        //31日期Picker
                        Picker(selection: $selectedDay, label: Text("日")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.green/*@END_MENU_TOKEN@*/)
                                .cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)) {
                            Group {
                                Text("1").tag(0)
                                Text("2").tag(1)
                                Text("3").tag(2)
                                Text("4").tag(3)
                                Text("5").tag(4)
                                Text("6").tag(5)
                                Text("7").tag(6)
                                Text("8").tag(7)
                                Text("9").tag(8)
                                Text("10").tag(9)
                            }
                            Group {
                                Text("11").tag(10)
                                Text("12").tag(11)
                                Text("13").tag(12)
                                Text("14").tag(13)
                                Text("15").tag(14)
                                Text("16").tag(15)
                                Text("17").tag(16)
                                Text("18").tag(17)
                                Text("19").tag(18)
                                Text("20").tag(19)
                            }
                            Group {
                                Text("21").tag(20)
                                Text("22").tag(21)
                                Text("23").tag(22)
                                Text("24").tag(23)
                                Text("25").tag(24)
                                Text("26").tag(25)
                                Text("27").tag(26)
                                Text("28").tag(27)
                                Text("29").tag(28)
                                Text("30").tag(29)
                            }
                            Group {
                                Text("31").tag(30)
                            }
                            
                        }
                        .animation(anima ? nil : Animation.easeInOut(duration: 4).speed(2))
                        .foregroundColor(Color.green)
                        .onChange(of: selectedDay, perform: { value in
                            self.anima = true
                            UserDefaults.standard.set(String(selectedDay+1), forKey: "day")
                        })
                        .onAppear{
                            let cc = "\(stringday ?? "1")"
                            let dd:Int? = Int(cc)!-1
                            self.selectedDay = dd ?? 0
                        }
                    }
                }
                .frame(height: 68.0)
                .navigationBarTitle("🍰Timetime")
//                .onReceive(NotificationCenter.default.publisher(for: WKExtension.applicationWillEnterForegroundNotification)
//                ) { _ in
//                    print("1111")
//                }
                //分割线
                Divider()
                    .padding(.vertical)
                
                let yearselceted =  Int(String(year[selectedYear]))
                let intyear = yearselceted!//int型年份
                let monthselceted =  Int(String(month[selectedMonth]))
                let intmonth = monthselceted!//int型月份
                let dayselceted =  Int(String(day[selectedDay]))
                let intday = dayselceted!//int型日期
                let str = "\(intyear)年\(intmonth)月\(intday)日"
                
                //进行转换
                let birthday = dateFormatter.date(from: str)
                //输出转换结果
                let unit : Calendar.Component = .day
                let end = Calendar.current.ordinality(of: unit, in: .era, for: today)
                let start = Calendar.current.ordinality(of: unit, in: .era, for: birthday!)
                //出生当天算一天
                let diff = end! - start!
                
                Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                    HStack {
                        Text("已来到世间:\(diff)天")
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                    }
                }
                .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                
                let ratioyear = String(format: "%.2f", yearbug(year: yearfresh(), day: yeardayfresh(), hour: hourfresh()))
                Button(action: {  self.lunarrr = lunar()
                        self.freshyear = String(format: "%.2f", yearbug(year: yearfresh(), day: yeardayfresh(), hour: hourfresh()))
                        self.freshmonth = String(format: "%.2f", monthbug(year: yearfresh(), month: monthfresh(), day: monthdayfresh(), hour: hourfresh()))
                        self.freshweek = String(format: "%.2f", weekbug(day: weekfresh(), hour: hourfresh()))
                        withAnimation(self.repeatingAnimation) { self.size = 1.05 }
                        self.size = 1.0}) {
                    HStack {
                        Label("本年：", systemImage: "y.circle")
                        Text("\(freshyear)"+"%")
                            .multilineTextAlignment(.trailing)
                            .frame(width: 70)
                    }
                    .scaleEffect(size)
                    .onTapGesture {
                        self.lunarrr = lunar()
                        self.freshyear = String(format: "%.2f", yearbug(year: yearfresh(), day: yeardayfresh(), hour: hourfresh()))
                        self.freshmonth = String(format: "%.2f", monthbug(year: yearfresh(), month: monthfresh(), day: monthdayfresh(), hour: hourfresh()))
                        self.freshweek = String(format: "%.2f", weekbug(day: weekfresh(), hour: hourfresh()))
                        withAnimation(self.repeatingAnimation) { self.size = 1.05 }
                        self.size = 1.0
                    }
                    .onAppear{
                        self.freshyear = ratioyear
                    }
                }
                .background(LinearGradient(gradient: Gradient(colors: [Color("cutegreen"), Color("cuteyellow")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                
                let ratiomonth = String(format: "%.2f", monthbug(year: yearfresh(), month: monthfresh(), day: monthdayfresh(), hour: hourfresh()))
                Button(action: {  self.lunarrr = lunar()
                        self.freshyear = String(format: "%.2f", yearbug(year: yearfresh(), day: yeardayfresh(), hour: hourfresh()))
                        self.freshmonth = String(format: "%.2f", monthbug(year: yearfresh(), month: monthfresh(), day: monthdayfresh(), hour: hourfresh()))
                        self.freshweek = String(format: "%.2f", weekbug(day: weekfresh(), hour: hourfresh()))
                        withAnimation(self.repeatingAnimation) { self.size = 1.05 }
                        self.size = 1.0}) {
                    HStack {
                        Label("本月：", systemImage: "m.circle")
                        Text("\(freshmonth)"+"%")
                            .multilineTextAlignment(.trailing)
                            .frame(width: 70)
                    }
                    .scaleEffect(size)
                    .onTapGesture {
                        self.lunarrr = lunar()
                        self.freshyear = String(format: "%.2f", yearbug(year: yearfresh(), day: yeardayfresh(), hour: hourfresh()))
                        self.freshmonth = String(format: "%.2f", monthbug(year: yearfresh(), month: monthfresh(), day: monthdayfresh(), hour: hourfresh()))
                        self.freshweek = String(format: "%.2f", weekbug(day: weekfresh(), hour: hourfresh()))
                        withAnimation(self.repeatingAnimation) { self.size = 1.05 }
                        self.size = 1.0
                    }
                    .onAppear{
                        self.freshmonth = ratiomonth
                    }
                }
                .background(LinearGradient(gradient: Gradient(colors: [Color("cuteblue"), Color("cutered")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                
                let ratioweek = String(format: "%.2f", weekbug(day: weekfresh(), hour: hourfresh()))
                Button(action: {  self.lunarrr = lunar()
                        self.freshyear = String(format: "%.2f", yearbug(year: yearfresh(), day: yeardayfresh(), hour: hourfresh()))
                        self.freshmonth = String(format: "%.2f", monthbug(year: yearfresh(), month: monthfresh(), day: monthdayfresh(), hour: hourfresh()))
                        self.freshweek = String(format: "%.2f", weekbug(day: weekfresh(), hour: hourfresh()))
                        withAnimation(self.repeatingAnimation) { self.size = 1.05 }
                        self.size = 1.0}) {
                    HStack {
                        Label("本周：", systemImage: "w.circle")
                        Text("\(freshweek)"+"%")
                            .multilineTextAlignment(.trailing)
                            .frame(width: 70)
                    }
                    .scaleEffect(size)
                    .onTapGesture {
                        self.lunarrr = lunar()
                        self.freshyear = String(format: "%.2f", yearbug(year: yearfresh(), day: yeardayfresh(), hour: hourfresh()))
                        self.freshmonth = String(format: "%.2f", monthbug(year: yearfresh(), month: monthfresh(), day: monthdayfresh(), hour: hourfresh()))
                        self.freshweek = String(format: "%.2f", weekbug(day: weekfresh(), hour: hourfresh()))
                        withAnimation(self.repeatingAnimation) { self.size = 1.05 }
                        self.size = 1.0
                        
                    }
                    .onAppear{
                        self.freshweek = ratioweek
                    }
                }
                .background(LinearGradient(gradient: Gradient(colors: [Color("cutegray"), Color("cutepurple")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                
                //分割线
                Divider()
                    .padding()
                
                Label("\(lunarrr)", systemImage: "arrow.triangle.2.circlepath")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .padding()
                    .scaleEffect(size)
                    .onTapGesture {
                        self.lunarrr = lunar()
                        self.freshyear = String(format: "%.2f", yearbug(year: yearfresh(), day: yeardayfresh(), hour: hourfresh()))
                        self.freshmonth = String(format: "%.2f", monthbug(year: yearfresh(), month: monthfresh(), day: monthdayfresh(), hour: hourfresh()))
                        self.freshweek = String(format: "%.2f", weekbug(day: weekfresh(), hour: hourfresh()))
                        withAnimation(self.repeatingAnimation) { self.size = 1.03 }
                        self.size = 1.0
                    }
                    .onAppear{
                        self.lunarrr = lunar()
                    }
                
                
                Group{
                    HStack(alignment: .bottom){
                        Button(action: {
                            if (self.isopen == true)
                            { UserDefaults.standard.set("false", forKey: "cyclerun")
                                self.isopen = false
                                withAnimation(Animation.easeInOut(duration: 1)) {
                                    self.showbar = false
                                }
                                //关闭通知
                                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["cycle"])
                                WKInterfaceDevice.current().play(.failure)
                            }
                            else
                            { UserDefaults.standard.set("true", forKey: "cyclerun")
                                self.isopen = true
                                withAnimation(Animation.easeInOut(duration: 1)) {
                                    self.showbar = true
                                }
                                let cycleselceted =  Int(String(countcycle[selected_cycle]))
                                let intcycle = cycleselceted!//int型cycle
                                let content = UNMutableNotificationContent()
                                content.title = "循环周期提醒: \(intcycle)分钟已到！"
                                // content.subtitle = "11"
                                content.sound = UNNotificationSound.defaultCritical
                                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(intcycle*60), repeats: true)
                                let request = UNNotificationRequest(identifier: "cycle", content: content, trigger: trigger)
                                UNUserNotificationCenter.current().add(request)
                                //打开通知
                                WKInterfaceDevice.current().play(.success)
                                //发送表盘
                                let server = CLKComplicationServer.sharedInstance()
                                for complication in server.activeComplications ?? [] {
                                    server.reloadTimeline(for: complication)
                                }
                                
                            }
                        }) {
                            Image(systemName: self.isopen == true ? "applewatch.radiowaves.left.and.right" : "applewatch")
                            Text(self.isopen == true ? "正在循环通知:" : "启动循环通知:")
                                .font(.footnote)
                        }
                        .background(self.isopen == true ? Color("cutegreen") : nil)
                        .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                        .onAppear{
                            if (self.stringcyclerun == "true" && self.isopen == false) {
                                self.isopen = true
                            }
                        }
                        Picker(selection: $selected_cycle, label: Text("")) {
                            ForEach(0 ..< countcycle.count) {
                                Text(self.countcycle[$0]).multilineTextAlignment(.center).tag($0)
                                    //设置40宽度使40mm下正常显示
                                    .foregroundColor(Color.blue)
                            }
                        }
                        .frame(width: 40.0, height:60)
                        
                        .onChange(of: selected_cycle, perform: { value in
                            UserDefaults.standard.set(String(selected_cycle+1), forKey: "cycle")
                            //关闭通知
                            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["cycle"])
                            
                            if self.isopen == true {
                                //发送表盘
//                                let server = CLKComplicationServer.sharedInstance()
//                                for complication in server.activeComplications ?? [] {
//                                    server.reloadTimeline(for: complication)
//                                }
                                //打开通知
                                let cycleselceted =  Int(String(countcycle[selected_cycle]))
                                let intcycle = cycleselceted!//int型cycle
                                let content = UNMutableNotificationContent()
                                content.title = "循环周期提醒: \(intcycle)分钟已到！"
                                // content.subtitle = "11"
                                content.sound = UNNotificationSound.defaultCritical
                                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(intcycle*60), repeats: true)
                                let request = UNNotificationRequest(identifier: "cycle", content: content, trigger: trigger)
                                UNUserNotificationCenter.current().add(request)
                            }
                        })
                        .onAppear{
                            let cc = "\(stringcycle ?? "1")"
                            let dd:Int? = Int(cc)!-1
                            self.selected_cycle = dd ?? 0
                        }
                        
                        
                        
                        
                    }
                    .padding(.bottom)

       
                    
//                    let solar = convert(year2: 1999, month2: 9, day2: 9)
//                    Text("公历：\(solar.0)年\(solar.1)月\(solar.2)日")
//                        .font(.footnote)
//                        .multilineTextAlignment(.center)
                  
                
                    
                    
                    HStack {
                        if showbar {
                            BarChartView(data: ChartData(points: [8,23,54,32,12,37,7,23,43]), title: "记录：", form: ChartForm.large, dropShadow: false)
                        }
                    }


                   
           

                
                    HStack{
                        Button(action: {self.showingInfoAlert = true}) {
                            HStack {
                                Image(systemName: "info.circle")
                                Text("帮助")
                                    .font(.footnote)
                            }
                        }
                        .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                        .frame(width: 70)
                        .alert(isPresented: $showingInfoAlert) {
                            Alert(title: Text("关于Timetime"),
                                  message: Text("\n" + "Timetime是一款腕上时间管理工具。" + "\("\n")\("\n")0⃣️【修复表盘】为强制更新表盘，若表盘出现--字符请点击此按钮，通常情况下，表盘会每个小时自动刷新一次，无需此功能。\("\n")1⃣️【循环通知】可用作番茄钟，感知时间和定时提醒等；长按拖动可调整顺序，左滑可删除。\("\n")2⃣️【记录时间点】一般记录如生日，纪念日等节点。\("\n")3⃣️【时间百分比】精度到小时，需要点击手动刷新❗️\("\n")4⃣️【阴历】需要点击手动刷新❗️").font(.footnote),
                                  dismissButton: .cancel(Text("好的")))
                        }
                        Button(action: {
                            let server = CLKComplicationServer.sharedInstance()
                            for complication in server.activeComplications ?? [] {
                                server.reloadTimeline(for: complication)
                            }
                            if self.isopen2 {
                            }
                            else{
                                self.isopen2 = true
                                //延时1秒执行
                                let time: TimeInterval = 0.2
                                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
                                    self.isopen2 = false
                                }
                            }
                            WKInterfaceDevice.current().play(.click)

                        }) {
                            HStack {
                                Image(systemName: "applewatch.watchface")
                                Text("修复表盘")
                                    .font(.footnote)
                            }
                        }
                        .background(self.isopen2 == true ? Color("cutegreen") : nil)
                        .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                    }
                }//group
                
            }
            //第二页
            VStack{
                Button(action: { self.isPresented.toggle() }) {
                    Spacer()
                    Text("Pure Days")
                    Spacer()
                    Spacer()
                    Image(systemName: "plus")
                    Spacer()
                    
                }
                .foregroundColor(Color.black)
                //.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("cutegreen2")/*@END_MENU_TOKEN@*/)
                .cornerRadius(20.0)
                .background(LinearGradient(gradient: Gradient(colors: [Color("cuteblue2"), Color("cuteyellow2")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                
                
                
                List {
                    ForEach(times, id: \.who) {
                        TimeRow(movie: $0)
                    }
                    .onDelete(perform: deleteMovie)
                    .onMove(perform: movemove)
                }
                .sheet(isPresented: $isPresented) {
                    AddTime { who, icon, release in
                        self.addTime(who: who, icon: icon, releaseDate: release)
                        self.isPresented = false
                    }
                }
            }
            .navigationBarTitle("🌟记录时间点")
            //第三页
       
            
     
    
        }//tabview
        .onAppear{get_data()
            requestNotificationPermissions()
        }
        
        
        
    }//view
    func movemove(from source: IndexSet, to destination: Int)
    {
        var revisedItems: [Time] = times.map{ $0 }
        revisedItems.move(fromOffsets: source, toOffset: destination )
        for reverseIndex in stride( from: revisedItems.count - 1,
                                    through: 0,
                                    by: -1 )
        {
            revisedItems[ reverseIndex ].userOrder =
                Int16( reverseIndex )
        }
        saveContext()
    }
    func deleteMovie(at offsets: IndexSet) {
        offsets.forEach { index in
            let movie = self.times[index]
            self.managedObjectContext.delete(movie)
        }
        saveContext()
    }
    func addTime(who: String, icon: String, releaseDate: Date) {
        let newMovie = Time(context: managedObjectContext)
        newMovie.who = who
        newMovie.icon = icon
        newMovie.releaseDate = releaseDate
        saveContext()
    }
    func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("保存出错: \(error)")
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}

extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(start, offsetBy: min(self.count - range.lowerBound,
                                             range.upperBound - range.lowerBound))
        return String(self[start..<end])
    }
    
    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        return String(self[start...])
    }
}
