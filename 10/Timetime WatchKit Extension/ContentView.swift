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
import LunarCore
func sematicStyle() -> ChartStyle {
        let style = Styles.barChartStyleNeonBlueDark
        style.darkModeStyle = Styles.barChartStyleNeonBlueDark
        return style
}

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


struct AddTime: View {
    static let DefaultWho = "null"
    static let Defaulticon = "🤪"
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
    @State private var selectedYear = 71
    @State private var selectedMonth = 6
    @State private var selectedDay = 1
    var year = ["1950", "1951", "1952", "1953", "1954", "1955", "1956", "1957", "1958", "1959", "1960", "1961", "1962", "1963", "1964", "1965", "1966", "1967", "1968", "1969", "1970", "1971", "1972", "1973", "1974", "1975", "1976", "1977", "1978", "1979", "1980", "1981", "1982", "1983", "1984", "1985", "1986", "1987", "1988", "1989", "1990", "1991", "1992", "1993", "1994", "1995", "1996", "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020", "2021", "2022", "2023", "2024", "2025", "2026", "2027", "2028", "2029", "2030", "2031", "2032", "2033", "2034", "2035"]
    var month = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    var day = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12","13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24","25", "26", "27", "28", "29", "30", "31"]
    @State private var isedit = true

    let onComplete: (String, String, Date) -> Void
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                HStack{
                    TextField("🤪", text: $icon)
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
                            self.isedit = false
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
                            self.isedit = false
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
                                    self.isedit = false
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
                                    self.isedit = false
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
                                self.isedit = false
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
                                self.isedit = false
                            })
                            
                        }
                    }
                    .frame(height: 68.0)
                }
                Divider()
                    .padding(.vertical)
                
                Section {
                    Button(action: (who.isEmpty || isedit) ? {} : addMoveAction) {
                        Text("完成")
                            .foregroundColor((who.isEmpty || isedit) ? Color("cutegreen") : Color.black)
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
            releaseDate
        )
        WKInterfaceDevice.current().play(.success)
        
    }
    
}

struct TimeRow: View {
    let movie: Time
    static let releaseFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        //formatter.dateStyle = .short
        return formatter
    }()
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        //formatter.dateStyle = .short
        formatter.dateFormat = "yyyy年MM月dd日"
        return formatter
    }
    func timefar(day: Date) -> Int {
        let unita : Calendar.Component = .day
        let enda = Calendar.current.ordinality(of: unita, in: .era, for: Date())
        let starta = Calendar.current.ordinality(of: unita, in: .era, for: day)
        let diffa = enda! - starta! - 1
        return abs(diffa)
    }
    func timefarthisyear(day: Date) -> Int {
        let dateyear = Calendar.current.component(.year, from: day )
        let datemonth = Calendar.current.component(.month, from: day )
        let dateday = Calendar.current.component(.day, from: day )
        let strrr = "\(yearfresh())年\(datemonth)月\(dateday)日"
        //进行转换
        let relativedate = dateFormatter.date(from: strrr) ?? Date()
        let unita : Calendar.Component = .day
        let enda = Calendar.current.ordinality(of: unita, in: .era, for: Date())
        let starta = Calendar.current.ordinality(of: unita, in: .era, for: relativedate)
        if dateyear == yearfresh(){
            let diffa = enda! - starta! - 1
            return abs(diffa)
        } else {
            let diffa = enda! - starta! - 1
            return abs(diffa)
        }
    }
    func lunartimefar(day: Date) -> Int {
        //获取当前的阳历数据
        let dateyear = Calendar.current.component(.year, from: day )
        let datemonth = Calendar.current.component(.month, from: day )
        let dateday = Calendar.current.component(.day, from: day )
        //转换为阴历数据
        let lunarCalendar = Calendar.init(identifier: .chinese)
        let lunarFormatter1 = DateFormatter()
        lunarFormatter1.locale = Locale(identifier: "zh_CN")
        lunarFormatter1.dateStyle = .short
        lunarFormatter1.calendar = lunarCalendar
        lunarFormatter1.dateFormat = "M"
        let lunarmonth = Int(lunarFormatter1.string(from: day))//阴历月份
        let lunarday0 = "\(LunarCore.solarToLunar(dateyear, datemonth, dateday)["lunarDay"]!)" as String
        let lunarday:Int? = Int(lunarday0)!//阴历天数
        
        //当下年份+阴历数据
        let solaryear = LunarCore.lunarToSolar(yearfresh(), lunarmonth!, lunarday!)["year"]
        let solarmonth = LunarCore.lunarToSolar(yearfresh(), lunarmonth!, lunarday!)["month"]
        let solarday = LunarCore.lunarToSolar(yearfresh(), lunarmonth!, lunarday!)["day"]
        let string = "\(solaryear!)年\(solarmonth!)月\(solarday!)日"
        //转换为date格式
        let lunardate = dateFormatter.date(from: string) ?? Date()
        
        let unita : Calendar.Component = .day
        let enda = Calendar.current.ordinality(of: unita, in: .era, for: lunardate)
        let starta = Calendar.current.ordinality(of: unita, in: .era, for: Date())
        let diffa = enda! - starta! + 1
        
        //            print("我是初始数据的阳历年份：\(dateyear)")
        //            print("我是初始数据的阳历月份：\(datemonth)")
        //            print("我是初始数据的阳历天数：\(dateday)")
        //            print("我是转换的阴历月份：\(lunarmonth!)")
        //            print("我是转换的阴历天数：\(lunarday!)")
        //            print("我是转换的最终的今年阳历数据：\(string)")
        //
        return diffa
        
    }
    var body: some View {
        VStack(alignment: .center){

        HStack(alignment: .center) {
            VStack(alignment: .leading){
                Spacer()
                movie.icon.map(Text.init)
                    .frame(width: 25.0)
                    .font(.title3)
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: false)
                Spacer()
            }
            .frame(width: 25.0)

            VStack(alignment: .center){
                movie.who.map(Text.init)
                    .font(.caption)
                    .frame(width: 95.0)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

            }
            VStack(alignment: .center){
                Spacer()
                movie.releaseDate.map { Text("公历：\(timefarthisyear(day: $0))")
                    .fontWeight(.bold) }
                    //.font(.footnote)
                    .font(.system(size:10))
                    .fixedSize(horizontal: true, vertical: false)
                    .frame(width: 30.0)
                    .foregroundColor(Color("cutepurple"))
                    .lineLimit(1)
                Spacer()
                movie.releaseDate.map { Text("农历：\(lunartimefar(day: $0))")
                    .fontWeight(.bold) }
                    //.font(.footnote)
                    .font(.system(size:10))
                    .fixedSize(horizontal: true, vertical: false)
                    .frame(width: 30.0)
                    .foregroundColor(Color("cutegreen"))
                    .lineLimit(1)
                //                    .overlay(
                //                        RoundedRectangle(cornerRadius: 5).stroke(Color("cuteyellow"), lineWidth: 0.5)
                //                    )
                Spacer()
            }
            Spacer()

        }
    
            Divider()
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            HStack(alignment: .center) {
                Spacer()
                movie.releaseDate.map { Text(Self.releaseFormatter.string(from: $0)) }
                    //.font(.footnote)
                    .font(.system(size:12))
                    //.frame(width: 88.0)
                    .foregroundColor(Color("cutegreen"))
                movie.releaseDate.map { Text("⇢\(timefar(day: $0))天") }
                    //.font(.footnote)
                    .font(.system(size:12))
                    .fixedSize(horizontal: true, vertical: false)
                    //.frame(width: 30.0)
                    .foregroundColor(Color("cuteyellow2"))
                    .lineLimit(1)
                //.rotationEffect(Angle(degrees: 90))
                Spacer()
            }
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
    //循环转换
    var dateFormatter_all: DateFormatter {
        let formatter = DateFormatter()
        //formatter.dateStyle = .short
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        //formatter.locale = Locale(identifier: "zh_CN")
        formatter.timeZone = TimeZone(abbreviation: "GMT+8")
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
    var todaydata: String {
        UserDefaults.standard.string(forKey: "\(yeardayfresh())") ?? "0.0"
    }
   // let todaydata = UserDefaults.standard.string(forKey: "\(yeardayfresh())")
    
    @State private var bartoday = 0.0
    let stringstart = UserDefaults.standard.string(forKey: "start")
    @State private var startdata = Date()
    @State private var enddata = Date()
    @State private var difff = 0

    var beforedata1: String { UserDefaults.standard.string(forKey: "\(yeardayfresh()-1)") ?? "0.0"}
    var beforedata2: String { UserDefaults.standard.string(forKey: "\(yeardayfresh()-2)") ?? "0.0"}
    var beforedata3: String { UserDefaults.standard.string(forKey: "\(yeardayfresh()-3)") ?? "0.0"}
    var beforedata4: String { UserDefaults.standard.string(forKey: "\(yeardayfresh()-4)") ?? "0.0"}
    var beforedata5: String { UserDefaults.standard.string(forKey: "\(yeardayfresh()-5)") ?? "0.0"}
    var beforedata6: String { UserDefaults.standard.string(forKey: "\(yeardayfresh()-6)") ?? "0.0"}
    

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
    
    @State var isPresented = false

    var body: some View {
        TabView(selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Selection@*/.constant(1)/*@END_MENU_TOKEN@*/) {
            //第一页
            ScrollView(showsIndicators: false) {
         
         
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
                .navigationBarTitle("🌟Timetime")
                .onReceive(NotificationCenter.default.publisher(for: WKExtension.applicationDidBecomeActiveNotification)
                ) { _ in
                    self.lunarrr = lunar()
                    self.freshyear = String(format: "%.2f", yearbug(year: yearfresh(), day: yeardayfresh(), hour: hourfresh()))
                    self.freshmonth = String(format: "%.2f", monthbug(year: yearfresh(), month: monthfresh(), day: monthdayfresh(), hour: hourfresh()))
                    self.freshweek = String(format: "%.2f", weekbug(day: weekfresh(), hour: hourfresh()))
                    withAnimation(self.repeatingAnimation) { self.size = 1.05 }
                    self.size = 1.0
                    //
                    let cc = "\(todaydata )"
                    let dd:Double? = Double(cc)!
                    self.bartoday = dd ?? 0.0
                }
                //分割线
                Divider()
                    .padding(.vertical)
                Group{
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
                
                    let iffestival = LunarCore.solarToLunar(yearfresh(), monthfresh(), monthdayfresh())["lunarFestival"]
                    if String(reflecting: iffestival) != "\(String(describing: Optional("")))" {
                        Button(action: {}) {
                            Text("今 天：   \(LunarCore.solarToLunar(yearfresh(), monthfresh(), monthdayfresh())["lunarFestival"]!)" as String)
                                .padding()
                                .font(.footnote)
                                .multilineTextAlignment(.center)
                        }
                        .frame(height: 30)
                        .cornerRadius(20.0)
                        .background(LinearGradient(gradient: Gradient(colors: [Color("cuteblue2"), Color("cuteyellow2")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                        .cornerRadius(20.0)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                    }
                    let iflunar24 = LunarCore.solarToLunar(yearfresh(), monthfresh(), monthdayfresh())["term"]
                    if String(reflecting: iflunar24) != "\(String(describing: Optional("")))" {
                        Button(action: {}) {
                            Text("今 天：   \(LunarCore.solarToLunar(yearfresh(), monthfresh(), monthdayfresh())["term"]!)" as String)
                                .padding()
                                .font(.footnote)
                                .multilineTextAlignment(.center)
                        }
                        .frame(height: 30)
                        .cornerRadius(20.0)
                        .background(LinearGradient(gradient: Gradient(colors: [Color("cuteblue2"), Color("cuteyellow2")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                        .cornerRadius(20.0)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                    }
                    
                    
                    
                Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                    HStack {
                        Text("已来到世间:\(diff)天")
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                    }
                }
                .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
      
                }//group

                
                
                
                
                
                
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
                //Divider()
                    //.padding(.all, 10.0)
                
                Label("\(lunarrr)", systemImage: "arrow.triangle.2.circlepath")
                    .font(.system(size:12))
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
                
                Divider()

                
                Group{
                    HStack(alignment: .bottom){
                        Button(action: {
                            if (self.isopen == true)
                            { UserDefaults.standard.set("false", forKey: "cyclerun")
                                self.isopen = false
                                withAnimation(Animation.easeInOut(duration: 1)) {
                                    self.showbar = false
                                }
                                self.enddata = Date()
                                let unit : Calendar.Component = .minute
                                let endd = Calendar.current.ordinality(of: unit, in: .era, for: enddata)
                                let startt = Calendar.current.ordinality(of: unit, in: .era, for: startdata)
                                self.difff = endd! - startt!
                                let saveddata = UserDefaults.standard.string(forKey: "\(yeardayfresh())")
                                let today_data:Double? = Double("\(saveddata ?? "0.0")")//double型旧数据
                                self.bartoday = today_data!+Double(difff)
                                UserDefaults.standard.set(String(bartoday), forKey: "\(yeardayfresh())")
                                
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
                                self.startdata = Date()
                                UserDefaults.standard.set("\(Date())", forKey: "start")
                    
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
//                                //发送表盘
//                                let server = CLKComplicationServer.sharedInstance()
//                                for complication in server.activeComplications ?? [] {
//                                    server.reloadTimeline(for: complication)
//                                }
                                
                            }
                        }) {
                            Image(systemName: self.isopen == true ? "applewatch.radiowaves.left.and.right" : "applewatch")
                            Text(self.isopen == true ? "正在循环通知" : "启动循环通知")
                                .font(.footnote)
                        }
                        .background(self.isopen == true ? Color("cutegreen") : nil)
                        .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                        .onAppear{
                            if (self.stringcyclerun == "true" && self.isopen == false) {
                                self.isopen = true
                                showbar = true
                            }
                        }
                        .padding(.top, 16.0)
                        .frame(height:57.5)

                        Picker(selection: $selected_cycle, label: Text("")) {
                            ForEach(0 ..< countcycle.count) {
                                Text(self.countcycle[$0]).multilineTextAlignment(.center).tag($0)
                                    //设置40宽度使40mm下正常显示
                                    .foregroundColor(Color.blue)
                            }
                        }
                        .frame(width: 38.0, height:57.5)
                        
                        .onChange(of: selected_cycle, perform: { value in
                            UserDefaults.standard.set(String(selected_cycle+1), forKey: "cycle")
                            //关闭通知
                            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["cycle"])
                            if self.isopen == true {
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
                        .onAppear{
                            let cc = "\(todaydata )"
                            let dd:Double? = Double(cc)!
                            self.bartoday = dd ?? 0.0
                        }
                        .onAppear{
                            let cc = "\(stringstart ?? "\(Date())")"
                            let dd = dateFormatter_all.date(from: cc)
                            self.startdata = dd ?? Date()
                        }
                    }
                    .frame(height:57.5, alignment: .center)
                    .padding(.bottom)

                    
                    
                    //let today_data:Double? = Double("\(todaydata ?? "0.0")")
                    var before_data1:Double? = Double("\(beforedata1 )")
                    var before_data2:Double? = Double("\(beforedata2 )")
                    var before_data3:Double? = Double("\(beforedata3 )")
                    var before_data4:Double? = Double("\(beforedata4 )")
                    var before_data5:Double? = Double("\(beforedata5 )")
                    var before_data6:Double? = Double("\(beforedata6 )")
                    
                    HStack {
                        if showbar {
                                    if ((yearfresh()-1)%4 == 0 && (yearfresh()-1)%100 != 0 || (yearfresh()-1)%400 == 0)
                                    {
                                        //366days
                                        if yeardayfresh() == 1 {
                                            BarChartView(data: ChartData(points: [newyearbug(beforedate: 361),newyearbug(beforedate: 362),newyearbug(beforedate: 363),newyearbug(beforedate: 364),newyearbug(beforedate: 365),newyearbug(beforedate: 366),bartoday]), title: "记录：", style: sematicStyle(), form: ChartForm.large, dropShadow: false, cornerImage:Image(systemName: "timelapse"))
                                                .onAppear{
                                                    UserDefaults.standard.removeObject(forKey: "360")
                                                }
                                            //删除360
                                        }
                                        else if yeardayfresh() == 2 {
                                            BarChartView(data: ChartData(points: [newyearbug(beforedate: 362),newyearbug(beforedate: 363),newyearbug(beforedate: 364),newyearbug(beforedate: 365),newyearbug(beforedate: 366),before_data1!,bartoday]), title: "记录：", style: sematicStyle(), form: ChartForm.large, dropShadow: false, cornerImage:Image(systemName: "timelapse"))
                                                .onAppear{
                                                    UserDefaults.standard.removeObject(forKey: "361")
                                                }
                                            //删除361
                                        }
                                        else if yeardayfresh() == 3 {
                                            BarChartView(data: ChartData(points: [newyearbug(beforedate: 363),newyearbug(beforedate: 364),newyearbug(beforedate: 365),newyearbug(beforedate: 366),before_data2!,before_data1!,bartoday]), title: "记录：", style: sematicStyle(), form: ChartForm.large, dropShadow: false, cornerImage:Image(systemName: "timelapse"))
                                                .onAppear{
                                                    UserDefaults.standard.removeObject(forKey: "362")
                                                }
                                            //删除362
                                        }
                                        else if yeardayfresh() == 4 {
                                            BarChartView(data: ChartData(points: [newyearbug(beforedate: 364),newyearbug(beforedate: 365),newyearbug(beforedate: 366),before_data3!,before_data2!,before_data1!,bartoday]), title: "记录：", style: sematicStyle(), form: ChartForm.large, dropShadow: false, cornerImage:Image(systemName: "timelapse"))
                                                .onAppear{
                                                    UserDefaults.standard.removeObject(forKey: "363")
                                                }
                                            //删除363
                                        }
                                        else if yeardayfresh() == 5 {
                                            BarChartView(data: ChartData(points: [newyearbug(beforedate: 365),newyearbug(beforedate: 366),before_data4!,before_data3!,before_data2!,before_data1!,bartoday]), title: "记录：", style: sematicStyle(), form: ChartForm.large, dropShadow: false, cornerImage:Image(systemName: "timelapse"))
                                                .onAppear{
                                                    UserDefaults.standard.removeObject(forKey: "364")
                                                }
                                            //删除364
                                        }
                                        else if yeardayfresh() == 6 {
                                            BarChartView(data: ChartData(points: [newyearbug(beforedate: 366),before_data5!,before_data4!,before_data3!,before_data2!,before_data1!,bartoday]), title: "记录：", style: sematicStyle(), form: ChartForm.large, dropShadow: false, cornerImage:Image(systemName: "timelapse"))
                                                .onAppear{
                                                    UserDefaults.standard.removeObject(forKey: "365")
                                                }
                                            //删除365
                                        }
                                        else if yeardayfresh() == 7 {
                                            BarChartView(data: ChartData(points: [before_data6!,before_data5!,before_data4!,before_data3!,before_data2!,before_data1!,bartoday]), title: "记录：", style: sematicStyle(), form: ChartForm.large, dropShadow: false, cornerImage:Image(systemName: "timelapse"))
                                                .onAppear{
                                                    UserDefaults.standard.removeObject(forKey: "366")
                                                }
                                            //删除366
                                        }
                                        else {
                                            BarChartView(data: ChartData(points: [before_data6!,before_data5!,before_data4!,before_data3!,before_data2!,before_data1!,bartoday]), title: "记录：", style: sematicStyle(), form: ChartForm.large, dropShadow: false, cornerImage:Image(systemName: "timelapse"))
                                                .onAppear{
                                                    UserDefaults.standard.removeObject(forKey: "\(yeardayfresh()-7)")
                                                }
                                        }
                                    }
                                    else {
                                        //365days
                                        if yeardayfresh() == 1 {
                                            BarChartView(data: ChartData(points: [newyearbug(beforedate: 360),newyearbug(beforedate: 361),newyearbug(beforedate: 362),newyearbug(beforedate: 363),newyearbug(beforedate: 364),newyearbug(beforedate: 365),bartoday]), title: "记录：", style: sematicStyle(), form: ChartForm.large, dropShadow: false, cornerImage:Image(systemName: "timelapse"))
                                                .onAppear{
                                                    UserDefaults.standard.removeObject(forKey: "359")
                                                }
                                            //删除359
                                        }
                                        else if yeardayfresh() == 2 {
                                            BarChartView(data: ChartData(points: [newyearbug(beforedate: 361),newyearbug(beforedate: 362),newyearbug(beforedate: 363),newyearbug(beforedate: 364),newyearbug(beforedate: 365),before_data1!,bartoday]), title: "记录：", style: sematicStyle(), form: ChartForm.large, dropShadow: false, cornerImage:Image(systemName: "timelapse"))
                                                .onAppear{
                                                    UserDefaults.standard.removeObject(forKey: "360")
                                                }
                                            //删除360
                                        }
                                        else if yeardayfresh() == 3 {
                                            BarChartView(data: ChartData(points: [newyearbug(beforedate: 362),newyearbug(beforedate: 363),newyearbug(beforedate: 364),newyearbug(beforedate: 365),before_data2!,before_data1!,bartoday]), title: "记录：", style: sematicStyle(), form: ChartForm.large, dropShadow: false, cornerImage:Image(systemName: "timelapse"))
                                                .onAppear{
                                                    UserDefaults.standard.removeObject(forKey: "361")
                                                }
                                            //删除361
                                        }
                                        else if yeardayfresh() == 4 {
                                            BarChartView(data: ChartData(points: [newyearbug(beforedate: 363),newyearbug(beforedate: 364),newyearbug(beforedate: 365),before_data3!,before_data2!,before_data1!,bartoday]), title: "记录：", style: sematicStyle(), form: ChartForm.large, dropShadow: false, cornerImage:Image(systemName: "timelapse"))
                                                .onAppear{
                                                    UserDefaults.standard.removeObject(forKey: "362")
                                                }
                                            //删除362
                                        }
                                        else if yeardayfresh() == 5 {
                                            BarChartView(data: ChartData(points: [newyearbug(beforedate: 364),newyearbug(beforedate: 365),before_data4!,before_data3!,before_data2!,before_data1!,bartoday]), title: "记录：", style: sematicStyle(), form: ChartForm.large, dropShadow: false, cornerImage:Image(systemName: "timelapse"))
                                                .onAppear{
                                                    UserDefaults.standard.removeObject(forKey: "363")
                                                }
                                            //删除363
                                        }
                                        else if yeardayfresh() == 6 {
                                            BarChartView(data: ChartData(points: [newyearbug(beforedate: 365),before_data5!,before_data4!,before_data3!,before_data2!,before_data1!,bartoday]), title: "记录：", style: sematicStyle(), form: ChartForm.large, dropShadow: false, cornerImage:Image(systemName: "timelapse"))
                                                .onAppear{
                                                    UserDefaults.standard.removeObject(forKey: "364")
                                                }
                                            //删除364
                                        }
                                        else if yeardayfresh() == 7 {
                                            BarChartView(data: ChartData(points: [before_data6!,before_data5!,before_data4!,before_data3!,before_data2!,before_data1!,bartoday]), title: "记录：", style: sematicStyle(), form: ChartForm.large, dropShadow: false, cornerImage:Image(systemName: "timelapse"))
                                                .onAppear{
                                                    UserDefaults.standard.removeObject(forKey: "365")
                                                }
                                            //删除365
                                        }
                                        else {
                                            BarChartView(data: ChartData(points: [before_data6!,before_data5!,before_data4!,before_data3!,before_data2!,before_data1!,bartoday]), title: "记录：", style: sematicStyle(), form: ChartForm.large, dropShadow: false, cornerImage:Image(systemName: "timelapse"))
                                                .onAppear{
                                                    UserDefaults.standard.removeObject(forKey: "\(yeardayfresh()-7)")
                                                }
                                        }
                                    }

                        }
                    }
                    .onReceive(NotificationCenter.default.publisher(for: WKExtension.applicationDidBecomeActiveNotification)
                    ) { _ in
               
                        before_data1 = Double("\(beforedata1 )")
                        before_data2 = Double("\(beforedata2 )")
                        before_data3 = Double("\(beforedata3 )")
                        before_data4 = Double("\(beforedata4 )")
                        before_data5 = Double("\(beforedata5 )")
                        before_data6 = Double("\(beforedata6 )")
              
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
                    
                    
                    NavigationLink(destination:
                        LunarCalendar(select: { date in
                        })
                    ) {
                        Text("弹出日历")
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
                .cornerRadius(20.0)

                List {
                    ForEach(times, id: \.who) {
                        TimeRow(movie: $0)
                    }
                    .onDelete(perform: deleteMovie)
                    .onMove(perform: movemove)
                }
                .listStyle(CarouselListStyle())
                .sheet(isPresented: $isPresented) {
                    AddTime { who, icon, release in
                        self.addTime(who: who, icon: icon, releaseDate: release)
                        self.isPresented = false
                    }
                }
            }
            .navigationBarTitle("📝记录时间点")
            //第三页
        
//            LunarCalendar(select: { date in
//            })
    
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
