//
//  Homeview.swift
//  Timetime WatchKit Extension
//
//  Created by 杨恒一 on 2021/11/20.
//

import SwiftUI
import Foundation
import UserNotifications
import ClockKit
import CoreData
import Combine
import LunarCore
import CloudKit

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
struct home: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext

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

    var year = ["1900", "1901", "1902", "1903", "1904", "1905", "1906", "1907", "1908", "1909", "1910", "1911", "1912", "1913", "1914", "1915", "1916", "1917", "1918", "1919", "1920", "1921", "1922", "1923", "1924", "1925", "1926", "1927", "1928", "1929", "1930", "1931", "1932", "1933", "1934", "1935", "1936", "1937", "1938", "1939", "1940", "1941", "1942", "1943", "1944", "1945", "1946", "1947", "1948", "1949", "1950", "1951", "1952", "1953", "1954", "1955", "1956", "1957", "1958", "1959", "1960", "1961", "1962", "1963", "1964", "1965", "1966", "1967", "1968", "1969", "1970", "1971", "1972", "1973", "1974", "1975", "1976", "1977", "1978", "1979", "1980", "1981", "1982", "1983", "1984", "1985", "1986", "1987", "1988", "1989", "1990", "1991", "1992", "1993", "1994", "1995", "1996", "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020", "2021", "2022", "2023", "2024", "2025", "2026", "2027", "2028", "2029", "2030", "2031", "2032", "2033", "2034", "2035"]
    var month = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    var day = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12","13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24","25", "26", "27", "28", "29", "30", "31"]
    var countcycle = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55", "60", "65", "70", "75", "80", "85", "90", "95"]

    @State private var today = Date()

    var stringyear: String {
        UserDefaults.standard.string(forKey: "year")!
    }
    var stringmonth: String {
        UserDefaults.standard.string(forKey: "month")!
    }
    var stringday: String {
        UserDefaults.standard.string(forKey: "day")!
    }
    var stringcycle: String {
        UserDefaults.standard.string(forKey: "cycle") ?? "7"
    }
    var stringstart: String {
        UserDefaults.standard.string(forKey: "start") ?? "\(Date())"
    }

    var todaydata: String {
        UserDefaults.standard.string(forKey: "\(yeardayfresh())") ?? "0.0"
    }

    @State private var selectedYear = 30
    @State private var selectedMonth = 6
    @State private var selectedDay = 1
    @State private var selected_cycle = 7

    @State private var bartoday = 0.0
    @State private var startdata = Date()
    @State private var enddata = Date()
    @State private var difff = 0
    @State private var newdiff = 0

    @State private var isopen = false
    @State private var isopen2 = false
    @State private var showingInfoAlert = false
    @State private var freshyear = 0.0
    @State private var freshmonth = 0.0
    @State private var freshweek = 0.0
    @State private var anima = false
    @State var size: CGFloat = 1.0
    @State private var showbar = false
    @State private var storewhile = true
    @State var wrongAttempt: Bool = false

    var beforedata1: String { UserDefaults.standard.string(forKey: "\(yeardayfresh()-1)") ?? "0.0"}
    var beforedata2: String { UserDefaults.standard.string(forKey: "\(yeardayfresh()-2)") ?? "0.0"}
    var beforedata3: String { UserDefaults.standard.string(forKey: "\(yeardayfresh()-3)") ?? "0.0"}
    var beforedata4: String { UserDefaults.standard.string(forKey: "\(yeardayfresh()-4)") ?? "0.0"}
    var beforedata5: String { UserDefaults.standard.string(forKey: "\(yeardayfresh()-5)") ?? "0.0"}
    var beforedata6: String { UserDefaults.standard.string(forKey: "\(yeardayfresh()-6)") ?? "0.0"}

    @State private var stringcyclerun = UserDefaults.standard.string(forKey: "cyclerun")

    var repeatingAnimation: Animation {
        Animation.easeInOut(duration: 0.3)
        //.delay(5)
        //.repeatForever()
    }
    var easeAnimation: Animation {
        Animation.easeInOut(duration: 4)
            .speed(3)
    }

    var saved_year3: Int {
        UserDefaults.standard.integer(forKey: "refreshdate")
    }

    
    var body: some View {
        
        //第一页
        ScrollView(showsIndicators: false) {

            ZStack(alignment: .top){
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
                    let cc = "\(stringyear)"
                    let dd:Int? = Int(cc)!-1
                    self.selectedYear = dd ?? 0
                }
                .pickerStyle(.wheel)


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
                    let cc = "\(stringmonth)"
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
                            let cc = "\(stringday)"
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
                            let cc = "\(stringday)"
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
                        let cc = "\(stringday)"
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
                        let cc = "\(stringday)"
                        let dd:Int? = Int(cc)!-1
                        self.selectedDay = dd ?? 0
                    }
                }
            }
            .frame(height: (WKInterfaceDevice.current().screenBounds.size.width == 184.0) ? 65.0 : 60.0)
            .navigationTitle("✨时鸟")
            .navBarTitleDisplayMode(.inline)
            .onReceive(NotificationCenter.default.publisher(for: WKExtension.applicationDidBecomeActiveNotification)
            ) { _ in
                self.freshyear = Double(yearbug(year: yearfresh(), day: yeardayfresh(), hour: hourfresh()))
                self.freshmonth = Double(monthbug(year: yearfresh(), month: monthfresh(), day: monthdayfresh(), hour: hourfresh()))
                self.freshweek = Double(weekbug(day: weekfresh(), hour: hourfresh()))

                withAnimation(self.repeatingAnimation) { self.size = 1.05 }
                self.size = 1.0
                //
                let cc = "\(todaydata )"
                let dd:Double? = Double(cc)!
                self.bartoday = dd ?? 0.0
                //
                self.wrongAttempt.toggle()

                let cc1 = "\(stringday)"
                let dd1:Int? = Int(cc1)!-1
                let selectedDay = dd1 ?? 0
                let dayselceted1 =  Int(String(day[selectedDay]))
                let intday = dayselceted1!//int型日期

                let cc2 = "\(stringmonth)"
                let dd2:Int? = Int(cc2)!-1
                let selectedMonth = dd2 ?? 0
                let monthselceted2 =  Int(String(month[selectedMonth]))
                let intmonth = monthselceted2!//int型月份

                let cc3 = "\(stringyear)"
                let dd3:Int? = Int(cc3)!-1
                let selectedYear = dd3 ?? 0
                let yearselceted3 =  Int(String(year[selectedYear]))
                let intyear = yearselceted3!//int型年份

                let str = "\(intyear)年\(intmonth)月\(intday)日"

                //进行转换
                let birthday = dateFormatter.date(from: str)
                //输出转换结果
                let unit : Calendar.Component = .day
                let end = Calendar.current.ordinality(of: unit, in: .era, for: today)
                let start = Calendar.current.ordinality(of: unit, in: .era, for: birthday!)
                //出生当天算一天
                let diff = end! - start!
                self.newdiff = diff


            }
            .onReceive(NotificationCenter.default.publisher(for: WKExtension.applicationDidFinishLaunchingNotification)
            ) { _ in
                self.wrongAttempt.toggle()
            }
            .onReceive(NotificationCenter.default.publisher(for: WKExtension.applicationDidEnterBackgroundNotification)
            ) { _ in
                print("进行刷新")
                var saved_refresh: Int {
                    UserDefaults.standard.integer(forKey: "refreshdate")
                }
                if Calendar.current.component(.hour, from: Date()) != saved_refresh {
                    print("重载表盘")
                    let server = CLKComplicationServer.sharedInstance()
                    for complication in server.activeComplications ?? [] {
                        server.reloadTimeline(for: complication)
                        print("重载表盘成功")
                    }
                    UserDefaults.standard.set(Calendar.current.component(.hour, from: Date()), forKey: "refreshdate")
                }
                self.freshyear = 0.0
                self.freshmonth = 0.0
                self.freshweek = 0.0
                //self.newdiff = 0
            }
            //阳历节日
                let ifsoloarfestival = LunarCore.solarToLunar(yearfresh(), monthfresh(), monthdayfresh())["solarFestival"]
                if String(reflecting: ifsoloarfestival) != "\(String(describing: Optional("")))" {
                    HStack(alignment: .center) {
                        Spacer()
                            Image(systemName: "bell.badge")
                                .foregroundColor(Color("cutepurple"))
                                .offset(x: wrongAttempt ? -3 : 0)
                                .animation(Animation.default.repeatCount(10).speed(5))
                                .onTapGesture {
                                    self.wrongAttempt.toggle()
                                }
                            Text("今天:   \(LunarCore.solarToLunar(yearfresh(), monthfresh(), monthdayfresh())["solarFestival"]!)" as String)
                                .foregroundColor(Color.white)
                                .font(.footnote)
                                .multilineTextAlignment(.center)
                                .lineLimit(1)
                        Spacer()

                    }
                    .padding(.vertical, 1.0)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.black/*@END_MENU_TOKEN@*/)
                }
                //阴历节日
                let iffestival = LunarCore.solarToLunar(yearfresh(), monthfresh(), monthdayfresh())["lunarFestival"]
                if String(reflecting: iffestival) != "\(String(describing: Optional("")))" {
                    HStack(alignment: .center) {
                        Spacer()
                        Image(systemName: "bell.badge")
                            .foregroundColor(Color("cutepurple"))
                            .offset(x: wrongAttempt ? -3 : 0)
                            .animation(Animation.default.repeatCount(10).speed(5))
                        Text("今天:   \(LunarCore.solarToLunar(yearfresh(), monthfresh(), monthdayfresh())["lunarFestival"]!)" as String)
                            .foregroundColor(Color.white)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .lineLimit(1)
                        Spacer()
                    }
                    .onTapGesture {
                        self.wrongAttempt.toggle()
                    }
                    .padding(.vertical, 1.0)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.black/*@END_MENU_TOKEN@*/)
                }
                //节气
                let iflunar24 = LunarCore.solarToLunar(yearfresh(), monthfresh(), monthdayfresh())["term"]
                if String(reflecting: iflunar24) != "\(String(describing: Optional("")))" {
                    HStack(alignment: .center) {
                        Spacer()
                            Image(systemName: "bell.badge")
                                .foregroundColor(Color("cutepurple"))
                                .offset(x: wrongAttempt ? -3 : 0)
                                .animation(Animation.default.repeatCount(10).speed(5))
                        Text("今天:   \(LunarCore.solarToLunar(yearfresh(), monthfresh(), monthdayfresh())["term"]!)" as String)
                            .foregroundColor(Color.white)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .lineLimit(1)
                        Spacer()
                        }
                    .onTapGesture {
                        self.wrongAttempt.toggle()
                    }
                    .padding(.vertical, 1.0)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.black/*@END_MENU_TOKEN@*/)
                }



        }
            //分割线
            Divider()
                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("cutegreen")/*@END_MENU_TOKEN@*/)
                .padding(.vertical, 5.0)
                .opacity(0.4)

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
                var diff = end! - start!
                HStack {
                    //Image(systemName: "plus.rectangle.fill")
                    Text((diff > 0) ? "已来到世间:\(diff)天" : "等待降临......")
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                }
                .onAppear{
                    diff = self.newdiff
                }
                .padding(.top, 1.0)

            }//group

            //分割线
            Divider()
                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("cutegreen")/*@END_MENU_TOKEN@*/)
                .padding(.vertical, 5.0)
                .opacity(0.4)


            let ratioyear = yearbug(year: yearfresh(), day: yeardayfresh(), hour: hourfresh())
            let ratiomonth = monthbug(year: yearfresh(), month: monthfresh(), day: monthdayfresh(), hour: hourfresh())
            let ratioweek = weekbug(day: weekfresh(), hour: hourfresh())
            HStack(spacing: 17) {
                ProgressBar(progress: Float(freshyear), whichratio: "年", whichcolor1: Color("cutegreen"), whichcolor2: Color("cutered"))
                    .frame(width: WKInterfaceDevice.current().screenBounds.size.width/4.0, height: 65.0)
                ProgressBar(progress: Float(freshmonth), whichratio: "月", whichcolor1: Color("cutegreen"), whichcolor2: Color("cutepurple"))
                    .frame(width: WKInterfaceDevice.current().screenBounds.size.width/4.0, height: 65.0)
                ProgressBar(progress: Float(freshweek), whichratio: "周", whichcolor1: Color("cutegreen"), whichcolor2: Color("cuteblue2"))
                    .frame(width: WKInterfaceDevice.current().screenBounds.size.width/4.0, height: 65.0)
            }
            .onAppear{
                self.freshyear = Double(ratioyear)
                self.freshmonth = Double(ratiomonth)
                self.freshweek = Double(ratioweek)
            }

            todayview()

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
                            let startday = Calendar.current.component(.day, from: startdata)
                            let endday = Calendar.current.component(.day, from: enddata)
                            if (startday == endday) {
                                let unit : Calendar.Component = .minute
                                let endd = Calendar.current.ordinality(of: unit, in: .era, for: enddata)
                                let startt = Calendar.current.ordinality(of: unit, in: .era, for: startdata)
                                self.difff = endd! - startt!
                                let saveddata = UserDefaults.standard.string(forKey: "\(yeardayfresh())")
                                let today_data:Double? = Double("\(saveddata ?? "0.0")")//double型旧数据
                                self.bartoday = storewhile ? today_data!+Double(difff) : today_data!
                                UserDefaults.standard.set(String(bartoday), forKey: "\(yeardayfresh())")

                            } else {
                                let unit : Calendar.Component = .minute
                                let endd = Calendar.current.ordinality(of: unit, in: .era, for: enddata)
                                let startt = Calendar.current.ordinality(of: unit, in: .era, for: startdata)
                                self.difff = (endd! - startt!)+1440
                                let saveddata = UserDefaults.standard.string(forKey: "\(yeardayfresh())")
                                let today_data:Double? = Double("\(saveddata ?? "0.0")")//double型旧数据
                                //self.bartoday = today_data!+Double(difff)
                                self.bartoday = storewhile ? today_data!+Double(difff) : today_data!
                                UserDefaults.standard.set(String(bartoday), forKey: "\(yeardayfresh())")
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
                            self.startdata = Date()
                            UserDefaults.standard.set("\(Date())", forKey: "start")
                            let cycleselceted =  Int(String(countcycle[selected_cycle]))
                            let intcycle = cycleselceted!//int型cycle
                            let content = UNMutableNotificationContent()
                            content.title = "循环周期提醒"
                            content.body = "\(intcycle)   分   钟   已   到   ！"
                            //content.body = "循环周期提醒: \(intcycle)分钟已到！"
                            content.sound = UNNotificationSound.defaultCritical
                            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(intcycle*60), repeats: true)
                            let request = UNNotificationRequest(identifier: "cycle", content: content, trigger: trigger)
                            UNUserNotificationCenter.current().add(request)
                            //打开通知
                            WKInterfaceDevice.current().play(.success)
                        }
                    }) {
                        Image(systemName: self.isopen == true ? "applewatch.radiowaves.left.and.right" : "applewatch")
                    Text(self.isopen == true ? "正在循环：" : "启动循环通知")
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

                    Picker(selection: $selected_cycle, label: Text("分钟").font(.system(size:10))) {
                        ForEach(0 ..< countcycle.count) {
                            Text(self.countcycle[$0]).multilineTextAlignment(.center).tag($0)
                                //设置40宽度使40mm下正常显示
                                .foregroundColor(Color.blue)
                        }
                    }
                    .frame(width: 38.0, height:(WKInterfaceDevice.current().screenBounds.size.width == 184.0) ? 57.5 : 55.0 )
                    .onChange(of: selected_cycle, perform: { value in
                        UserDefaults.standard.set(String(selected_cycle+1), forKey: "cycle")
                        //关闭通知
                        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["cycle"])
                        if self.isopen == true {
                            //打开通知
                            let cycleselceted =  Int(String(countcycle[selected_cycle]))
                            let intcycle = cycleselceted!//int型cycle
                            let content = UNMutableNotificationContent()
                            content.title = "循环周期提醒"
                            content.body = "\(intcycle)   分   钟   已   到   ！"
                            content.sound = UNNotificationSound.defaultCritical
                            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(intcycle*60), repeats: true)
                            let request = UNNotificationRequest(identifier: "cycle", content: content, trigger: trigger)
                            UNUserNotificationCenter.current().add(request)
                        }
                    })
                    .onAppear{
                       //let cc = "\(stringcycle ?? "1")"
                        let cc = "\(stringcycle)"
                        let dd:Int? = Int(cc)!-1
                        self.selected_cycle = dd ?? 0
                    }
                    .onAppear{
                        let cc = "\(todaydata )"
                        let dd:Double? = Double(cc)!
                        self.bartoday = dd ?? 0.0
                    }
                    .onAppear{
                        //let cc = "\(stringstart ?? "\(Date())")"
                        let cc = "\(stringstart)"
                        let dd = dateFormatter_all.date(from: cc)
                        self.startdata = dd ?? Date()
                    }
                }
                .frame(height:57.5, alignment: .center)
                //.padding(.bottom)

                //let today_data:Double? = Double("\(todaydata ?? "0.0")")
                var before_data1:Double? = Double("\(beforedata1 )")
                var before_data2:Double? = Double("\(beforedata2 )")
                var before_data3:Double? = Double("\(beforedata3 )")
                var before_data4:Double? = Double("\(beforedata4 )")
                var before_data5:Double? = Double("\(beforedata5 )")
                var before_data6:Double? = Double("\(beforedata6 )")

                VStack {

                    if showbar {
                        if ((yearfresh()-1)%4 == 0 && (yearfresh()-1)%100 != 0 || (yearfresh()-1)%400 == 0)
                        {
                            //366days
                            if yeardayfresh() == 1 {
                                BarChartView(data: ChartData(points: [newyearbug(beforedate: 361),newyearbug(beforedate: 362),newyearbug(beforedate: 363),newyearbug(beforedate: 364),newyearbug(beforedate: 365),newyearbug(beforedate: 366),bartoday]), title: "记录：", style: sematicStyle(), form: ChartForm.large, dropShadow: false, cornerImage:Image(systemName: "timelapse"))
                                    .frame(width:100)
                                    .onAppear{
                                        UserDefaults.standard.removeObject(forKey: "360")
                                    }
                                //删除360
                                //分割线
                                Divider()
                                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("cutegreen")/*@END_MENU_TOKEN@*/)
                                    .padding(.bottom, 3.0)
                                    .opacity(0.4)

                                Toggle(isOn: $storewhile) {
                                    Text("记录本次循环时长")
                                        .font(.footnote)
                                }
                                .onTapGesture {
                                    self.storewhile.toggle()
                                }
                                .padding(.horizontal)

                            }
                            else if yeardayfresh() == 2 {
                                BarChartView(data: ChartData(points: [newyearbug(beforedate: 362),newyearbug(beforedate: 363),newyearbug(beforedate: 364),newyearbug(beforedate: 365),newyearbug(beforedate: 366),before_data1!,bartoday]), title: "记录：", style: sematicStyle(), form: ChartForm.large, dropShadow: false, cornerImage:Image(systemName: "timelapse"))
                                    .frame(width:100)
                                    .onAppear{
                                        UserDefaults.standard.removeObject(forKey: "361")
                                    }
                                //删除361
                                //分割线
                                Divider()
                                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("cutegreen")/*@END_MENU_TOKEN@*/)
                                    .padding(.bottom, 3.0)
                                    .opacity(0.4)

                                Toggle(isOn: $storewhile) {
                                    Text("记录本次循环时长")
                                        .font(.footnote)
                                }
                                .onTapGesture {
                                    self.storewhile.toggle()
                                }
                                .padding(.horizontal)

                            }
                            else if yeardayfresh() == 3 {
                                BarChartView(data: ChartData(points: [newyearbug(beforedate: 363),newyearbug(beforedate: 364),newyearbug(beforedate: 365),newyearbug(beforedate: 366),before_data2!,before_data1!,bartoday]), title: "记录：", style: sematicStyle(), form: ChartForm.large, dropShadow: false, cornerImage:Image(systemName: "timelapse"))
                                    .frame(width:100)
                                    .onAppear{
                                        UserDefaults.standard.removeObject(forKey: "362")
                                    }
                                //删除362
                                //分割线
                                Divider()
                                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("cutegreen")/*@END_MENU_TOKEN@*/)
                                    .padding(.bottom, 3.0)
                                    .opacity(0.4)

                                Toggle(isOn: $storewhile) {
                                    Text("记录本次循环时长")
                                        .font(.footnote)
                                }
                                .onTapGesture {
                                    self.storewhile.toggle()
                                }
                                .padding(.horizontal)

                            }
                            else if yeardayfresh() == 4 {
                                BarChartView(data: ChartData(points: [newyearbug(beforedate: 364),newyearbug(beforedate: 365),newyearbug(beforedate: 366),before_data3!,before_data2!,before_data1!,bartoday]), title: "记录：", style: sematicStyle(), form: ChartForm.large, dropShadow: false, cornerImage:Image(systemName: "timelapse"))
                                    .frame(width:100)
                                    .onAppear{
                                        UserDefaults.standard.removeObject(forKey: "363")
                                    }
                                //删除363
                                //分割线
                                Divider()
                                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("cutegreen")/*@END_MENU_TOKEN@*/)
                                    .padding(.bottom, 3.0)
                                    .opacity(0.4)

                                Toggle(isOn: $storewhile) {
                                    Text("记录本次循环时长")
                                        .font(.footnote)
                                }
                                .onTapGesture {
                                    self.storewhile.toggle()
                                }
                                .padding(.horizontal)

                            }
                            else if yeardayfresh() == 5 {
                                BarChartView(data: ChartData(points: [newyearbug(beforedate: 365),newyearbug(beforedate: 366),before_data4!,before_data3!,before_data2!,before_data1!,bartoday]), title: "记录：", style: sematicStyle(), form: ChartForm.large, dropShadow: false, cornerImage:Image(systemName: "timelapse"))
                                    .frame(width:100)
                                    .onAppear{
                                        UserDefaults.standard.removeObject(forKey: "364")
                                    }
                                //删除364
                                //分割线
                                Divider()
                                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("cutegreen")/*@END_MENU_TOKEN@*/)
                                    .padding(.bottom, 3.0)
                                    .opacity(0.4)

                                Toggle(isOn: $storewhile) {
                                    Text("记录本次循环时长")
                                        .font(.footnote)
                                }
                                .onTapGesture {
                                    self.storewhile.toggle()
                                }
                                .padding(.horizontal)

                            }
                            else if yeardayfresh() == 6 {
                                BarChartView(data: ChartData(points: [newyearbug(beforedate: 366),before_data5!,before_data4!,before_data3!,before_data2!,before_data1!,bartoday]), title: "记录：", style: sematicStyle(), form: ChartForm.large, dropShadow: false, cornerImage:Image(systemName: "timelapse"))
                                    .frame(width:100)
                                    .onAppear{
                                        UserDefaults.standard.removeObject(forKey: "365")
                                    }
                                //删除365
                                //分割线
                                Divider()
                                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("cutegreen")/*@END_MENU_TOKEN@*/)
                                    .padding(.bottom, 3.0)
                                    .opacity(0.4)

                                Toggle(isOn: $storewhile) {
                                    Text("记录本次循环时长")
                                        .font(.footnote)
                                }
                                .onTapGesture {
                                    self.storewhile.toggle()
                                }
                                .padding(.horizontal)

                            }
                            else if yeardayfresh() == 7 {
                                BarChartView(data: ChartData(points: [before_data6!,before_data5!,before_data4!,before_data3!,before_data2!,before_data1!,bartoday]), title: "记录：", style: sematicStyle(), form: ChartForm.large, dropShadow: false, cornerImage:Image(systemName: "timelapse"))
                                    .frame(width:100)
                                    .onAppear{
                                        UserDefaults.standard.removeObject(forKey: "366")
                                    }
                                //删除366
                                //分割线
                                Divider()
                                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("cutegreen")/*@END_MENU_TOKEN@*/)
                                    .padding(.bottom, 3.0)
                                    .opacity(0.4)

                                Toggle(isOn: $storewhile) {
                                    Text("记录本次循环时长")
                                        .font(.footnote)
                                }
                                .onTapGesture {
                                    self.storewhile.toggle()
                                }
                                .padding(.horizontal)

                            }
                            else {
                                BarChartView(data: ChartData(points: [before_data6!,before_data5!,before_data4!,before_data3!,before_data2!,before_data1!,bartoday]), title: "记录：", style: sematicStyle(), form: ChartForm.large, dropShadow: false, cornerImage:Image(systemName: "timelapse"))
                                    .frame(width:100)
                                    .onAppear{
                                        for  barnumber in 1 ..< (yeardayfresh()-7) + 1 {
                                            //print(barnumber)
                                            UserDefaults.standard.removeObject(forKey: "\(barnumber)")
                                        }
                                       // UserDefaults.standard.removeObject(forKey: "\(yeardayfresh()-7)")
                                    }
                                //分割线
                                Divider()
                                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("cutegreen")/*@END_MENU_TOKEN@*/)
                                    .padding(.bottom, 3.0)
                                    .opacity(0.4)

                                Toggle(isOn: $storewhile) {
                                    Text("记录本次循环时长")
                                        .font(.footnote)
                                }
                                .onTapGesture {
                                    self.storewhile.toggle()
                                }
                                .padding(.horizontal)

                            }
                        }
                        else {
                            //365days
                            if yeardayfresh() == 1 {
                                BarChartView(data: ChartData(points: [newyearbug(beforedate: 360),newyearbug(beforedate: 361),newyearbug(beforedate: 362),newyearbug(beforedate: 363),newyearbug(beforedate: 364),newyearbug(beforedate: 365),bartoday]), title: "记录：", style: sematicStyle(), form: ChartForm.large, dropShadow: false, cornerImage:Image(systemName: "timelapse"))
                                    .frame(width:100)
                                    .onAppear{
                                        UserDefaults.standard.removeObject(forKey: "359")
                                    }
                                //删除359
                                //分割线
                                Divider()
                                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("cutegreen")/*@END_MENU_TOKEN@*/)
                                    .padding(.bottom, 3.0)
                                    .opacity(0.4)

                                Toggle(isOn: $storewhile) {
                                    Text("记录本次循环时长")
                                        .font(.footnote)
                                }
                                .onTapGesture {
                                    self.storewhile.toggle()
                                }
                                .padding(.horizontal)

                            }
                            else if yeardayfresh() == 2 {
                                BarChartView(data: ChartData(points: [newyearbug(beforedate: 361),newyearbug(beforedate: 362),newyearbug(beforedate: 363),newyearbug(beforedate: 364),newyearbug(beforedate: 365),before_data1!,bartoday]), title: "记录：", style: sematicStyle(), form: ChartForm.large, dropShadow: false, cornerImage:Image(systemName: "timelapse"))
                                    .frame(width:100)
                                    .onAppear{
                                        UserDefaults.standard.removeObject(forKey: "360")
                                    }
                                //删除360
                                //分割线
                                Divider()
                                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("cutegreen")/*@END_MENU_TOKEN@*/)
                                    .padding(.bottom, 3.0)
                                    .opacity(0.4)

                                Toggle(isOn: $storewhile) {
                                    Text("记录本次循环时长")
                                        .font(.footnote)
                                }
                                .onTapGesture {
                                    self.storewhile.toggle()
                                }
                                .padding(.horizontal)

                            }
                            else if yeardayfresh() == 3 {
                                BarChartView(data: ChartData(points: [newyearbug(beforedate: 362),newyearbug(beforedate: 363),newyearbug(beforedate: 364),newyearbug(beforedate: 365),before_data2!,before_data1!,bartoday]), title: "记录：", style: sematicStyle(), form: ChartForm.large, dropShadow: false, cornerImage:Image(systemName: "timelapse"))
                                    .frame(width:100)
                                    .onAppear{
                                        UserDefaults.standard.removeObject(forKey: "361")
                                    }
                                //删除361
                                //分割线
                                Divider()
                                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("cutegreen")/*@END_MENU_TOKEN@*/)
                                    .padding(.bottom, 3.0)
                                    .opacity(0.4)

                                Toggle(isOn: $storewhile) {
                                    Text("记录本次循环时长")
                                        .font(.footnote)
                                }
                                .onTapGesture {
                                    self.storewhile.toggle()
                                }
                                .padding(.horizontal)

                            }
                            else if yeardayfresh() == 4 {
                                BarChartView(data: ChartData(points: [newyearbug(beforedate: 363),newyearbug(beforedate: 364),newyearbug(beforedate: 365),before_data3!,before_data2!,before_data1!,bartoday]), title: "记录：", style: sematicStyle(), form: ChartForm.large, dropShadow: false, cornerImage:Image(systemName: "timelapse"))
                                    .frame(width:100)
                                    .onAppear{
                                        UserDefaults.standard.removeObject(forKey: "362")
                                    }
                                //删除362
                                //分割线
                                Divider()
                                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("cutegreen")/*@END_MENU_TOKEN@*/)
                                    .padding(.bottom, 3.0)
                                    .opacity(0.4)

                                Toggle(isOn: $storewhile) {
                                    Text("记录本次循环时长")
                                        .font(.footnote)
                                }
                                .onTapGesture {
                                    self.storewhile.toggle()
                                }
                                .padding(.horizontal)

                            }
                            else if yeardayfresh() == 5 {
                                BarChartView(data: ChartData(points: [newyearbug(beforedate: 364),newyearbug(beforedate: 365),before_data4!,before_data3!,before_data2!,before_data1!,bartoday]), title: "记录：", style: sematicStyle(), form: ChartForm.large, dropShadow: false, cornerImage:Image(systemName: "timelapse"))
                                    .frame(width:100)
                                    .onAppear{
                                        UserDefaults.standard.removeObject(forKey: "363")
                                    }
                                //删除363
                                //分割线
                                Divider()
                                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("cutegreen")/*@END_MENU_TOKEN@*/)
                                    .padding(.bottom, 3.0)
                                    .opacity(0.4)

                                Toggle(isOn: $storewhile) {
                                    Text("记录本次循环时长")
                                        .font(.footnote)
                                }
                                .onTapGesture {
                                    self.storewhile.toggle()
                                }
                                .padding(.horizontal)

                            }
                            else if yeardayfresh() == 6 {
                                BarChartView(data: ChartData(points: [newyearbug(beforedate: 365),before_data5!,before_data4!,before_data3!,before_data2!,before_data1!,bartoday]), title: "记录：", style: sematicStyle(), form: ChartForm.large, dropShadow: false, cornerImage:Image(systemName: "timelapse"))
                                    .frame(width:100)
                                    .onAppear{
                                        UserDefaults.standard.removeObject(forKey: "364")
                                    }
                                //删除364
                                //分割线
                                Divider()
                                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("cutegreen")/*@END_MENU_TOKEN@*/)
                                    .padding(.bottom, 3.0)
                                    .opacity(0.4)

                                Toggle(isOn: $storewhile) {
                                    Text("记录本次循环时长")
                                        .font(.footnote)
                                }
                                .onTapGesture {
                                    self.storewhile.toggle()
                                }
                                .padding(.horizontal)

                            }
                            else if yeardayfresh() == 7 {
                                BarChartView(data: ChartData(points: [before_data6!,before_data5!,before_data4!,before_data3!,before_data2!,before_data1!,bartoday]), title: "记录：", style: sematicStyle(), form: ChartForm.large, dropShadow: false, cornerImage:Image(systemName: "timelapse"))
                                    .frame(width:100)
                                    .onAppear{
                                        UserDefaults.standard.removeObject(forKey: "365")
                                    }
                                //删除365
                                //分割线
                                Divider()
                                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("cutegreen")/*@END_MENU_TOKEN@*/)
                                    .padding(.bottom, 3.0)
                                    .opacity(0.4)

                                Toggle(isOn: $storewhile) {
                                    Text("记录本次循环时长")
                                        .font(.footnote)
                                }
                                .onTapGesture {
                                    self.storewhile.toggle()
                                }
                                .padding(.horizontal)

                            }
                            else {
                                BarChartView(data: ChartData(points: [before_data6!,before_data5!,before_data4!,before_data3!,before_data2!,before_data1!,bartoday]), title: "记录：", style: sematicStyle(), form: ChartForm.large, dropShadow: false, cornerImage:Image(systemName: "timelapse"))
                                    .frame(width:100)
                                    .onAppear{
                                        for  barnumber in 1 ..< (yeardayfresh()-7) + 1 {
                                            //print(barnumber)
                                            UserDefaults.standard.removeObject(forKey: "\(barnumber)")
                                        }
                                        //UserDefaults.standard.removeObject(forKey: "\(yeardayfresh()-7)")
                                    }
                                //分割线
                                Divider()
                                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("cutegreen")/*@END_MENU_TOKEN@*/)
                                    .padding(.bottom, 3.0)
                                    .opacity(0.4)

                                Toggle(isOn: $storewhile) {
                                    Text("记录本次循环时长")
                                        .font(.footnote)
                                }
                                .onTapGesture {
                                    self.storewhile.toggle()
                                }
                                .padding(.horizontal)

                            }
                        }

                    }
                }
                .padding(.bottom, 3.0)
                .onReceive(NotificationCenter.default.publisher(for: WKExtension.applicationDidBecomeActiveNotification)
                ) { _ in
                    before_data1 = Double("\(beforedata1 )")
                    before_data2 = Double("\(beforedata2 )")
                    before_data3 = Double("\(beforedata3 )")
                    before_data4 = Double("\(beforedata4 )")
                    before_data5 = Double("\(beforedata5 )")
                    before_data6 = Double("\(beforedata6 )")
                }
//
//                    Divider()
//                        .padding(.vertical)
                //分割线
                Divider()
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("cutegreen")/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 3.0)
                    .opacity(0.4)

            

                HStack{
                    //测试修复

                
                    NavigationLink(destination: info()) {
                        HStack {
                            Image(systemName: "info.circle")
                                .foregroundColor(Color("cuteyellow2"))
                            Text("秘籍")
                                .font(.footnote)
                                .foregroundColor(Color("cuteyellow2"))

                        }
                    }
                    .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                    //.frame(width: 70)

                    NavigationLink(destination:
                                    LunarCalendar(select: { date in
                                    })
                    ) {
                        HStack {
                            Image(systemName: "calendar.circle")
                                .foregroundColor(Color("cutepurple"))
                            Text("日历")
                                .font(.footnote)
                                .foregroundColor(Color("cutepurple"))

                        }
                    }
                    .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                }

                NavigationLink(destination: timetool()
                ) {
                    HStack {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(Color("cuteblue2"))
                        Text("时间计算器")
                            .font(.footnote)
                            .foregroundColor(Color("cuteblue2"))
                    }
                }
                .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)


                VStack{
                        Text("凯风发而").font(.system(size:9)) + Text("时鸟").font(.system(size:9)).foregroundColor(Color("cutepurple")) + Text("讙，微波动而水虫鸣。").font(.system(size:9))
                        Text("取自 三国·魏·曹植《节游赋》")
                            .font(.system(size:9))
                }
                .padding(.top)

                Text("\(moon())时鸟 V2.6")
                    .font(.system(size:9))
                    .padding(.top)

            }//group
        }
        
        
        
        
    


        
        
        
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
//修复watchOS 8动态标题栏bug
extension View {
    @ViewBuilder
    func navBarTitleDisplayMode(_ mode: NavigationBarItem.TitleDisplayMode) -> some View {
        if #available(watchOSApplicationExtension 8.0, *) {
            self
                .navigationBarTitleDisplayMode(mode)
        } else {
            self
        }
    }
}

