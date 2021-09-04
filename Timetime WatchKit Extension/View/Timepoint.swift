//
//  Timepoint.swift
//  Timetime WatchKit Extension
//
//  Created by 杨恒一 on 2021/4/13.
//

import Foundation
import SwiftUI
import UserNotifications
import CoreData
import LunarCore

func noti(year: Int, month: Int, day: Int, during: Int, islunar: String, whoo: String) {
    if during == 7{
        //打开通知
        let content = UNMutableNotificationContent()
        content.title = "【\(whoo)】将7天后到达[\(islunar)]计算节点，请及时做好安排"
        content.sound = UNNotificationSound.defaultCritical
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = 8
        dateComponents.minute = 30
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "\(whoo)\(during)", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    } else if during == 3 {
        let content = UNMutableNotificationContent()
        content.title = "【\(whoo)】将3天后到达[\(islunar)]计算节点，请及时做好安排"
        content.sound = UNNotificationSound.defaultCritical
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = 8
        dateComponents.minute = 30
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "\(whoo)\(during)", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    else if during == 1 {
        let content = UNMutableNotificationContent()
        content.title = "【\(whoo)】将明天到达[\(islunar)]计算节点，别忘记了"
        content.sound = UNNotificationSound.defaultCritical
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = 9
        dateComponents.minute = 30
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "\(whoo)\(during)", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    else if during == 0 {
        let content = UNMutableNotificationContent()
        content.title = "【\(whoo)】今天已到[\(islunar)]计算节点！"
        content.sound = UNNotificationSound.defaultCritical
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = 8
        dateComponents.minute = 30
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "\(whoo)\(during)", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}
private func addnotification(whooo: String, releaseDateee: Date) {
//    func noti7(date: Date, Islunar: String){
//        //没有相对阴历公历通知，仅有公历倒计时
//        var dateComponent7 = DateComponents()
//        dateComponent7.day = -7
//        let notidate7 = Calendar.current.date(byAdding: dateComponent7, to: date)
//        let dateyear7 = Calendar.current.component(.year, from: notidate7! )
//        let datemonth7 = Calendar.current.component(.month, from: notidate7! )
//        let dateday7 = Calendar.current.component(.day, from: notidate7! )
//        noti(year: dateyear7, month: datemonth7, day: dateday7, during: 7, islunar: Islunar, whoo: whooo)
//        print("\(Islunar)-提前7天通知：\(dateyear7)年\(datemonth7)月\(dateday7)")
//    }
    func noti3(date: Date, Islunar: String){
        var dateComponent3 = DateComponents()
        dateComponent3.day = -3
        let notidate3 = Calendar.current.date(byAdding: dateComponent3, to: date)
        let dateyear3 = Calendar.current.component(.year, from: notidate3! )
        let datemonth3 = Calendar.current.component(.month, from: notidate3! )
        let dateday3 = Calendar.current.component(.day, from: notidate3! )
        noti(year: dateyear3, month: datemonth3, day: dateday3, during: 3, islunar: Islunar, whoo: whooo)
        print("\(Islunar)-提前3天通知：\(dateyear3)年\(datemonth3)月\(dateday3)")
    }
    func noti1(date: Date, Islunar: String){
        var dateComponent1 = DateComponents()
        dateComponent1.day = -1
        let notidate1 = Calendar.current.date(byAdding: dateComponent1, to: date)
        let dateyear1 = Calendar.current.component(.year, from: notidate1! )
        let datemonth1 = Calendar.current.component(.month, from: notidate1! )
        let dateday1 = Calendar.current.component(.day, from: notidate1! )
        noti(year: dateyear1, month: datemonth1, day: dateday1, during: 1, islunar: Islunar, whoo: whooo)
        print("\(Islunar)-提前1天通知：\(dateyear1)年\(datemonth1)月\(dateday1)")
    }
    func timefar(day: Date) -> Int {
        let unita : Calendar.Component = .day
        let starta = Calendar.current.ordinality(of: unita, in: .era, for: Date())
        let enda = Calendar.current.ordinality(of: unita, in: .era, for: day)
        let diffa = enda! - starta! + 1
        return diffa
    }
    //let dateyear = Calendar.current.component(.year, from: Date() )
    let intyear = Calendar.current.component(.year, from: releaseDateee )
    let intmonth = Calendar.current.component(.month, from: releaseDateee )
    let intday = Calendar.current.component(.day, from: releaseDateee )
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        //formatter.dateStyle = .short
        formatter.dateFormat = "yyyy年MM月dd日"
        return formatter
    }
    //相对阳历
    let solormonth = Calendar.current.component(.month, from: releaseDateee )
    let solorday = Calendar.current.component(.day, from: releaseDateee )
    let strrr = "\(yearfresh())年\(solormonth)月\(solorday)日"
    let relativedate = dateFormatter.date(from: strrr) ?? Date()
    
    //相对阴历
    let dateyear2 = Calendar.current.component(.year, from: releaseDateee )
    let datemonth = Calendar.current.component(.month, from: releaseDateee )
    let dateday = Calendar.current.component(.day, from: releaseDateee )
    let lunarCalendar = Calendar.init(identifier: .chinese)
    let lunarFormatter1 = DateFormatter()
    lunarFormatter1.locale = Locale(identifier: "zh_CN")
    lunarFormatter1.dateStyle = .short
    lunarFormatter1.calendar = lunarCalendar
    lunarFormatter1.dateFormat = "M"
    let lunarmonth = Int(lunarFormatter1.string(from: releaseDateee))//阴历月份
    let lunarday0 = "\(LunarCore.solarToLunar(dateyear2, datemonth, dateday)["lunarDay"]!)" as String
    let lunarday:Int? = Int(lunarday0)!//阴历天数
    let solaryear = LunarCore.lunarToSolar(yearfresh(), lunarmonth!, lunarday!)["year"]
    let solarmonth = LunarCore.lunarToSolar(yearfresh(), lunarmonth!, lunarday!)["month"]
    let solarday = LunarCore.lunarToSolar(yearfresh(), lunarmonth!, lunarday!)["day"]
    let string = "\(solaryear!)年\(solarmonth!)月\(solarday!)日"
    let lunardate = dateFormatter.date(from: string) ?? Date()
    print("************************************")
    print("事件名称：\(whooo)")
    print("相对阴历：\(string)")
    print("相对阳历：\(strrr)")
    
    if (timefar(day: releaseDateee)>0) {
        print("大于等于本天")
        print("releaseDate为：\(releaseDateee)")
        print("时间间隔：\(timefar(day: releaseDateee))")
        
        if timefar(day: releaseDateee) > 3 {
            print("大于3天")
            noti3(date: releaseDateee, Islunar: "公历")
            noti(year: intyear, month: intmonth, day: intday, during: 0, islunar: "公历", whoo: whooo)
        } else if (1 < timefar(day: releaseDateee)) && (timefar(day: releaseDateee) < 3) {
            noti1(date: releaseDateee, Islunar: "公历")
            noti(year: intyear, month: intmonth, day: intday, during: 0, islunar: "公历", whoo: whooo)
        } else {
            noti(year: intyear, month: intmonth, day: intday, during: 0, islunar: "公历", whoo: whooo)
        }
    }
    else {
        //本年相对公历阴历发送通知
        print("小于本天")
        print("relativedate为：\(relativedate)")
        print("公历时间间隔：\(timefar(day: relativedate))")
        if timefar(day: relativedate) > 3 {
            noti3(date: relativedate, Islunar: "每年公历")
            noti(year: yearfresh(), month: intmonth, day: intday, during: 0, islunar: "每年公历", whoo: whooo)
        } else if (1 < timefar(day: relativedate)) && (timefar(day: relativedate) < 3) {
            noti1(date: relativedate, Islunar: "每年公历")
            noti(year: yearfresh(), month: intmonth, day: intday, during: 0, islunar: "每年公历", whoo: whooo)
        } else {
            noti(year: yearfresh(), month: intmonth, day: intday, during: 0, islunar: "每年公历", whoo: whooo)
        }

        print("lunardate为：\(lunardate)")
        print("农历时间间隔：\(timefar(day: lunardate))")
        if timefar(day: lunardate) > 3 {
            noti3(date: lunardate, Islunar: "每年农历")
            noti(year: solaryear as! Int, month: solarmonth as! Int, day: solarday as! Int, during: 0, islunar: "每年农历", whoo: whooo)
        } else if (1 < timefar(day: lunardate)) && (timefar(day: lunardate) < 3) {
            noti1(date: lunardate, Islunar: "每年农历")
            noti(year: solaryear as! Int, month: solarmonth as! Int, day: solarday as! Int, during: 0, islunar: "每年农历", whoo: whooo)
        } else {
            noti(year: solaryear as! Int, month: solarmonth as! Int, day: solarday as! Int, during: 0, islunar: "每年农历", whoo: whooo)
        }
        
        
    }
    
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
    @State private var selectedYear = (0 <= (yearfresh()-1950) && (yearfresh()-1950) <= 85) ? yearfresh()-1950 : 71
    @State private var selectedMonth = monthfresh()-1
    @State private var selectedDay = monthdayfresh()-1
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
                    //(who.isEmpty || isedit) ? {} : addMoveAction
                    Button(action: who.isEmpty ? {} : addMoveAction) {
                        Text("完成")
                            //(who.isEmpty || isedit) ? Color("cutegreen") : Color.black
                            .foregroundColor(who.isEmpty ? Color("cutegreen") : Color.black)
                    }
                    .foregroundColor(Color.black)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("cutegreen")/*@END_MENU_TOKEN@*/)
                    .cornerRadius(20.0)
                }

                
            }
        }
    }
 
    
    private func addMoveAction() {
        let yearselceted =  Int(String(year[selectedYear]))
        let intyear = yearselceted!//int型年份
        let monthselceted =  Int(String(month[selectedMonth]))
        let intmonth = monthselceted!//int型月份
        let dayselceted =  Int(String(day[selectedDay]))
        let intday = dayselceted!//int型日期
        let str = "\(intyear)年\(intmonth)月\(intday)日"
        self.releaseDate = dateFormatter.date(from: str)!
        
        onComplete(
            who.isEmpty ? AddTime.DefaultWho : who,
            icon.isEmpty ? AddTime.Defaulticon : icon,
            releaseDate
        )
        WKInterfaceDevice.current().play(.success)
        addnotification(whooo: who, releaseDateee: releaseDate)
        //注册通知时间戳
        let saved_dynamicnoti = UserDefaults.standard.string(forKey: "dynamicnoti")
        if saved_dynamicnoti != nil {}
        else{
            UserDefaults.standard.set("\(yearfresh())", forKey: "dynamicnoti")
        }
        
    }
    
}
struct inf: View {
    let movie: Time
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        return formatter
    }
    var lunarFormatter1: DateFormatter {
        let lunarFormatter = DateFormatter()
        lunarFormatter.locale = Locale(identifier: "zh_CN")
        lunarFormatter.dateStyle = .short
        lunarFormatter.calendar = Calendar.init(identifier: .chinese)
        lunarFormatter.dateFormat = "M"
        return lunarFormatter
    }
    var body: some View {
        //相对阳历
        let solormonth = Calendar.current.component(.month, from: movie.releaseDate! )
        let solorday = Calendar.current.component(.day, from: movie.releaseDate! )
        let strrr = "\(yearfresh())年\(solormonth)月\(solorday)日"
        //相对阴历
        let dateyear2 = Calendar.current.component(.year, from: movie.releaseDate! )
        let datemonth = Calendar.current.component(.month, from: movie.releaseDate! )
        let dateday = Calendar.current.component(.day, from: movie.releaseDate! )
        let lunarmonth = Int(lunarFormatter1.string(from: movie.releaseDate!))//阴历月份
        let lunarday0 = "\(LunarCore.solarToLunar(dateyear2, datemonth, dateday)["lunarDay"]!)" as String
        let lunarday:Int? = Int(lunarday0)!//阴历天数
        let solaryear = LunarCore.lunarToSolar(yearfresh(), lunarmonth!, lunarday!)["year"]
        let solarmonth = LunarCore.lunarToSolar(yearfresh(), lunarmonth!, lunarday!)["month"]
        let solarday = LunarCore.lunarToSolar(yearfresh(), lunarmonth!, lunarday!)["day"]
        let string = "\(solaryear!)年\(solarmonth!)月\(solarday!)日"
        let lunarday00 = "\(LunarCore.solarToLunar(dateyear2, datemonth, dateday)["lunarMonthName"]!)\(LunarCore.solarToLunar(dateyear2, datemonth, dateday)["lunarDayName"]!)" as String

        ScrollView(showsIndicators: false) {
            Text("事件：\(movie.who!)")
                .lineLimit(1)
                .padding(.bottom)
            Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                VStack{
                    Text("本年公历通知点")
                        .font(.caption)
                Text("\(strrr)")
                    .font(.footnote)
                    .foregroundColor(Color("cutepurple"))
                }
            }
            .cornerRadius(20.0)

            
            Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                VStack{
                    Text("本年农历通知点")
                        .font(.caption)
                    Text("\(string)")
                        .font(.footnote)
                        .foregroundColor(Color("cutegreen"))
                    Text("（每年：\(lunarday00)）")
                        .font(.footnote)
                        .foregroundColor(Color("cutegreen"))
                }
            }
            .cornerRadius(20.0)

            Label("已注册通知提醒", systemImage: "checkmark.circle")
                .font(.footnote)
                .foregroundColor(Color("cutegreen3"))

            
        }
        
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
    func timefar(day: Date) -> String {
        let unita : Calendar.Component = .day
        let enda = Calendar.current.ordinality(of: unita, in: .era, for: Date())
        let starta = Calendar.current.ordinality(of: unita, in: .era, for: day)
        let diffa = enda! - starta! - 1
        if diffa > 0 {
            return "\(diffa)天↑"
        } else if diffa < 0{
            return "\(abs(diffa))天↓"
        } else {
            return "\(diffa)天"
        }
    }
    func timefarthisyear(day: Date) -> String {
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
            if diffa > 0 {
                return "\(diffa)天↑"
            } else if diffa < 0{
                return "\(abs(diffa))天↓"
            } else {
                return "\(diffa)天"
            }

        } else {
            let diffa = enda! - starta! - 1
            if diffa > 0 {
                return "\(diffa)天↑"
            } else if diffa < 0{
                return "\(abs(diffa))天↓"
            } else {
                return "\(diffa)天"
            }

        }
    }
    func lunartimefar(day: Date) -> String {
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
        
        if diffa > 0 {
            return "\(diffa)天↓"
        } else if diffa < 0{
            return "\(abs(diffa))天↑"
        } else {
            return "\(diffa)天"
        }
    }
    
    @State var lunarnum = ""
    @State var solarnum = ""
    @State var largenum = ""

    var body: some View {
        NavigationLink(destination: inf(movie: movie)) {
            VStack(alignment: .center){
                HStack(alignment: .center) {
                    VStack(alignment: .leading){
                        Spacer()
                        movie.icon.map(Text.init)
                            .frame(width: 24.0)
                            .font(.title3)
                            .lineLimit(1)
                            .fixedSize(horizontal: true, vertical: false)
                        Spacer()
                    }
                    //.frame(width: 25.0)
                    .frame(width: 22.0)

                    VStack(alignment: .center){
                        movie.who.map(Text.init)
                            .font(.caption)
                            //.frame(width: 100.0)
                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    .frame(width: (WKInterfaceDevice.current().screenBounds.size.width == 184.0) ? 85.0 : 66.0)
                    Spacer()

                    VStack(alignment: .leading){
                        Spacer()
                        movie.releaseDate.map { _ in Text("公历:\(solarnum)")}
                            //.font(.footnote)
                            //.fontWeight(.bold)
                            .font(.system(size:10))
                            .fixedSize(horizontal: true, vertical: false)
                            .frame(width: 30.0)
                            .foregroundColor(Color("cutepurple"))
                            .lineLimit(1)
                        Spacer()
                        movie.releaseDate.map { _ in Text("农历:\(lunarnum)")}
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
                    .frame(width: 30.0)

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
                    movie.releaseDate.map { _ in Text("⇢\(largenum)") }
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
            .onAppear{
                self.lunarnum = lunartimefar(day: movie.releaseDate!)
                self.solarnum = timefarthisyear(day: movie.releaseDate!)
                self.largenum = timefar(day: movie.releaseDate!)

                addnotification(whooo: movie.who!, releaseDateee: movie.releaseDate!)
                let stringdynamicnoti = UserDefaults.standard.string(forKey: "dynamicnoti")!
                //print("存储时间戳为：\(stringdynamicnoti)")
                //print("当前时间点为：\(yearfresh())")
                if stringdynamicnoti != "\(yearfresh())" {
                print("重新注册通知")
                addnotification(whooo: movie.who!, releaseDateee: movie.releaseDate!)
                }
                UserDefaults.standard.set("\(yearfresh())", forKey: "dynamicnoti")
            }
        }
        
    }
}
