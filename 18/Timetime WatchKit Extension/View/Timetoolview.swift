//
//  timetool.swift
//  Timetime WatchKit Extension
//
//  Created by 杨恒一 on 2021/3/12.
//

import Foundation
import SwiftUI
import LunarCore

struct timetool: View {
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        //formatter.dateStyle = .short
        formatter.dateFormat = "yyyy年M月d日"
        return formatter
    }
    var year = ["1950", "1951", "1952", "1953", "1954", "1955", "1956", "1957", "1958", "1959", "1960", "1961", "1962", "1963", "1964", "1965", "1966", "1967", "1968", "1969", "1970", "1971", "1972", "1973", "1974", "1975", "1976", "1977", "1978", "1979", "1980", "1981", "1982", "1983", "1984", "1985", "1986", "1987", "1988", "1989", "1990", "1991", "1992", "1993", "1994", "1995", "1996", "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020", "2021", "2022", "2023", "2024", "2025", "2026", "2027", "2028", "2029", "2030", "2031", "2032", "2033", "2034", "2035"]
    var month = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    var day = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12","13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24","25", "26", "27", "28", "29", "30", "31"]
    @State private var selectedYear1 = 71
    @State private var selectedMonth1 = 6
    @State private var selectedDay1 = 1
    @State private var selectedYear2 = 71
    @State private var selectedMonth2 = 6
    @State private var selectedDay2 = 1
    @State private var ischoosesolor = true
    @State private var selectedadd = 1
    @State private var selectedadd1 = 0
    @State private var selectedadd2 = 0
    @State private var selectedadd3 = 0
    @State private var difff = 0

    var body: some View {
        
        ScrollView{
            Button(action: {
                self.ischoosesolor.toggle()
            }) {
                    Label(ischoosesolor ? "输入为:公历" : "输入为:农历", systemImage: "cursorarrow.click.badge.clock")
                        .foregroundColor(.black)
                    
                }
                .frame(height: 30.0)
                .background(ischoosesolor ? Color("cuteblue2") : Color("cuteyellow2"))
                .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
            
            
            
            //输入信息
            HStack {
                //年份Picker
                Picker(selection: $selectedYear1, label: Text("")
                    ) {
                    ForEach(0 ..< year.count) {
                        Text(self.year[$0]).multilineTextAlignment(.center).frame(width: 45.0).tag($0)
                        //设置40宽度使40mm下正常显示
                    }
                }
                .foregroundColor(Color.green)
                .onChange(of: selectedYear1, perform: { value in
                })
                .onAppear{

                }
                
                //月份Picker
                Picker(selection: $selectedMonth1, label: Text("")
   ) {
                    
                    ForEach(0 ..< month.count) {
                        Text(self.month[$0]).tag($0)
                    }
                }
                .foregroundColor(Color.green)
                .onChange(of: selectedMonth1, perform: { value in
                })
                .onAppear{

                }
                
                let yearselceted =  Int(String(year[selectedYear1]))
                let intyear = yearselceted!//int型年份
                let monthselceted =  Int(String(month[selectedMonth1]))
                let intmonth = monthselceted!//int型月份
                
                //注意且或的逻辑顺序，易错
                if intmonth == 2
                {
                    if (intyear%4 == 0 && intyear%100 != 0 || intyear%400 == 0)
                    {
                        //29日期Picker
                        Picker(selection: $selectedDay1, label: Text("")
                 ){
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
                        .onChange(of: selectedDay1, perform: { value in
                        })
                        .onAppear{
    
                        }
                    }
                    else
                    {
                        //28日期Picker
                        Picker(selection: $selectedDay1, label: Text("")
               ){
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
                        .onChange(of: selectedDay1, perform: { value in
                        })
                        .onAppear{
 
                        }
                    }
                }
                
                if (intmonth == 4 || intmonth == 6 || intmonth == 9 || intmonth == 11)
                {
                    //30日期Picker
                    Picker(selection: $selectedDay1, label: Text("")
                     ) {
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
                    .onChange(of: selectedDay1, perform: { value in
                    })
                    .onAppear{

                    }
                }
                
                if (intmonth == 1 || intmonth == 3 || intmonth == 5 || intmonth == 7 || intmonth == 8 || intmonth == 10 || intmonth == 12)
                {
                    //31日期Picker
                    Picker(selection: $selectedDay1, label: Text("")
                       ) {
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
                    .onChange(of: selectedDay1, perform: { value in
                    })
                    .onAppear{
  
                    }
                }
            }
            .frame(height: (WKInterfaceDevice.current().screenBounds.size.width == 184.0) ? 55.0 : 50.0)
            
            let yearselceted1 =  Int(String(year[selectedYear1]))
            let intyear1 = yearselceted1!//int型年份
            let monthselceted1 =  Int(String(month[selectedMonth1]))
            let intmonth1 = monthselceted1!//int型月份
            let dayselceted1 =  Int(String(day[selectedDay1]))
            let intday1 = dayselceted1!//int型日期
            let str = "\(intyear1)年\(intmonth1)月\(intday1)日"
            //进行转换
            let startday = dateFormatter.date(from: str)

            Text(ischoosesolor ? "农历:\("\(LunarCore.solarToLunar(intyear1,intmonth1,intday1)["GanZhiYear"]!)")\("\(LunarCore.solarToLunar(intyear1,intmonth1,intday1)["zodiac"]!)年")\("\(LunarCore.solarToLunar(intyear1,intmonth1,intday1)["lunarMonthName"]!)\("\(LunarCore.solarToLunar(intyear1,intmonth1,intday1)["lunarDayName"]!)")")⏎" : "公历:\("\(LunarCore.lunarToSolar(intyear1,intmonth1,intday1)["year"]!)年")\("\(LunarCore.lunarToSolar(intyear1,intmonth1,intday1)["month"]!)月")\("\(LunarCore.lunarToSolar(intyear1,intmonth1,intday1)["day"]!)日")⏎")
                .font(.footnote)
                .foregroundColor(ischoosesolor ? Color("cuteyellow2") : Color("cuteblue2"))
                .padding(.bottom, -40.0)
            
            HStack(alignment: .bottom){
                Picker(selection: $selectedadd, label: Text("")) {
                    Text("减").tag(-1)
                    Text("加").tag(1)
                }
                .frame(height: 50.0)

                Picker(selection: $selectedadd1, label: Text("")) {
                    Text("0").tag(0)
                    Text("1").tag(1)
                    Text("2").tag(2)
                    Text("3").tag(3)
                    Text("4").tag(4)
                    Text("5").tag(5)
                    Text("6").tag(6)
                    Text("7").tag(7)
                    Text("8").tag(8)
                    Text("9").tag(9)
                }
                .frame(width: 33.0, height: 50.0)
                Picker(selection: $selectedadd2, label: Text("")) {
                    Text("0").tag(0)
                    Text("1").tag(1)
                    Text("2").tag(2)
                    Text("3").tag(3)
                    Text("4").tag(4)
                    Text("5").tag(5)
                    Text("6").tag(6)
                    Text("7").tag(7)
                    Text("8").tag(8)
                    Text("9").tag(9)
                }
                .frame(width: 33.0, height: 50.0)
                Picker(selection: $selectedadd3, label: Text("")) {
                    Text("0").tag(0)
                    Text("1").tag(1)
                    Text("2").tag(2)
                    Text("3").tag(3)
                    Text("4").tag(4)
                    Text("5").tag(5)
                    Text("6").tag(6)
                    Text("7").tag(7)
                    Text("8").tag(8)
                    Text("9").tag(9)
                }
                .frame(width: 33.0, height: 50.0)
            }
            let addnumber = selectedadd*(selectedadd1*100+selectedadd2*10+selectedadd3)//int型选择数字

            let rightTime = Calendar.current.date(byAdding: .day, value: addnumber, to: startday!, wrappingComponents: false)
            
            let str3 = "\(LunarCore.lunarToSolar(intyear1,intmonth1,intday1)["year"]!)年\(LunarCore.lunarToSolar(intyear1,intmonth1,intday1)["month"]!)月\(LunarCore.lunarToSolar(intyear1,intmonth1,intday1)["day"]!)日"
            //进行转换
            let startday2 = dateFormatter.date(from: str3)
            let rightTime2 = Calendar.current.date(byAdding: .day, value: addnumber, to: startday2!, wrappingComponents: false)
            
            Text(ischoosesolor ? "公历:\(dateFormatter.string(from: rightTime!))⏎" : "公历:\(dateFormatter.string(from: rightTime2!))⏎")
                .font(.footnote)
                .foregroundColor(Color("cuteblue2"))


            Text(ischoosesolor ? "农历:\("\(LunarCore.solarToLunar(Calendar.current.component(.year, from: rightTime! ),Calendar.current.component(.month, from: rightTime! ),Calendar.current.component(.day, from: rightTime! ))["GanZhiYear"]!)")\("\(LunarCore.solarToLunar(Calendar.current.component(.year, from: rightTime! ),Calendar.current.component(.month, from: rightTime! ),Calendar.current.component(.day, from: rightTime! ))["zodiac"]!)")年\("\(LunarCore.solarToLunar(Calendar.current.component(.year, from: rightTime! ),Calendar.current.component(.month, from: rightTime! ),Calendar.current.component(.day, from: rightTime! ))["lunarMonthName"]!)")\("\(LunarCore.solarToLunar(Calendar.current.component(.year, from: rightTime! ),Calendar.current.component(.month, from: rightTime! ),Calendar.current.component(.day, from: rightTime! ))["lunarDayName"]!)")⏎" : "农历:\("\(LunarCore.solarToLunar(Calendar.current.component(.year, from: rightTime2! ),Calendar.current.component(.month, from: rightTime2! ),Calendar.current.component(.day, from: rightTime2! ))["GanZhiYear"]!)")\("\(LunarCore.solarToLunar(Calendar.current.component(.year, from: rightTime2! ),Calendar.current.component(.month, from: rightTime2! ),Calendar.current.component(.day, from: rightTime2! ))["zodiac"]!)")年\("\(LunarCore.solarToLunar(Calendar.current.component(.year, from: rightTime2! ),Calendar.current.component(.month, from: rightTime2! ),Calendar.current.component(.day, from: rightTime2! ))["lunarMonthName"]!)")\("\(LunarCore.solarToLunar(Calendar.current.component(.year, from: rightTime2! ),Calendar.current.component(.month, from: rightTime2! ),Calendar.current.component(.day, from: rightTime2! ))["lunarDayName"]!)")⏎")
                .font(.footnote)
                .foregroundColor(Color("cuteyellow2"))

            
            Divider()
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            //公历计算
            let yearselceted2 =  Int(String(year[selectedYear2]))
            let intyear2 = yearselceted2!//int型年份
            let monthselceted2 =  Int(String(month[selectedMonth2]))
            let intmonth2 = monthselceted2!//int型月份
            let dayselceted2 =  Int(String(day[selectedDay2]))
            let intday2 = dayselceted2!//int型日期
            let str2 = "\(intyear2)年\(intmonth2)月\(intday2)日"
            //进行转换
            let endday = dateFormatter.date(from: str2)
            //输出转换结果
            let unit : Calendar.Component = .day
            let end = Calendar.current.ordinality(of: unit, in: .era, for: endday!)
            let start = Calendar.current.ordinality(of: unit, in: .era, for: startday!)
            //出生当天算一天
            let difff = abs(end! - start!)
            //农历计算
            let solarstr2 = "\(LunarCore.lunarToSolar(intyear1,intmonth1,intday1)["year"]!)年\(LunarCore.lunarToSolar(intyear1,intmonth1,intday1)["month"]!)月\(LunarCore.lunarToSolar(intyear1,intmonth1,intday1)["day"]!)日"
            //进行转换
            let startday22 = dateFormatter.date(from: solarstr2)
            let solarstr3 = "\(LunarCore.lunarToSolar(intyear2,intmonth2,intday2)["year"]!)年\(LunarCore.lunarToSolar(intyear2,intmonth2,intday2)["month"]!)月\(LunarCore.lunarToSolar(intyear2,intmonth2,intday2)["day"]!)日"
            //进行转换
            let endday33 = dateFormatter.date(from: solarstr3)
            //输出转换结果
            let unit2 : Calendar.Component = .day
            let end2 = Calendar.current.ordinality(of: unit2, in: .era, for: endday33!)
            let start2 = Calendar.current.ordinality(of: unit2, in: .era, for: startday22!)
            //出生当天算一天
            let difff2 = abs(end2! - start2!)
            
            Text(ischoosesolor ? "公历相差:\(difff)天" : "农历相差:\(difff2)天")
                .font(.caption)
                .foregroundColor(ischoosesolor ? Color.white : Color.black)
                .frame(width: 150.0)
                .background(ischoosesolor ? Color("cutegreen3") : Color.yellow)
                .cornerRadius(/*@START_MENU_TOKEN@*/15.0/*@END_MENU_TOKEN@*/)
                .padding(.bottom, -10.0)
            
            

            //输入信息
            HStack {
                //年份Picker
                Picker(selection: $selectedYear2, label: Text("")
                 ) {
                    ForEach(0 ..< year.count) {
                        Text(self.year[$0]).multilineTextAlignment(.center).frame(width: 45.0).tag($0)
                        //设置40宽度使40mm下正常显示
                    }
                }
                .foregroundColor(Color.green)
                .onChange(of: selectedYear2, perform: { value in

     
                })

                //月份Picker
                Picker(selection: $selectedMonth2, label: Text("")
                ) {
                    
                    ForEach(0 ..< month.count) {
                        Text(self.month[$0]).tag($0)
                    }
                }
                .foregroundColor(Color.green)
                .onChange(of: selectedMonth2, perform: { value in
            

                })
                
                let yearselceted =  Int(String(year[selectedYear2]))
                let intyear = yearselceted!//int型年份
                let monthselceted =  Int(String(month[selectedMonth2]))
                let intmonth = monthselceted!//int型月份
                
                //注意且或的逻辑顺序，易错
                if intmonth == 2
                {
                    if (intyear%4 == 0 && intyear%100 != 0 || intyear%400 == 0)
                    {
                        //29日期Picker
                        Picker(selection: $selectedDay2, label: Text("")
                        ){
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
                        .onChange(of: selectedDay2, perform: { value in
  
                        })
                        
                        
                        
                    }
                    else
                    {
                        //28日期Picker
                        Picker(selection: $selectedDay2, label: Text("")
                 ){
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
                        .onChange(of: selectedDay2, perform: { value in
      
                            })
                    }
                }
                
                if (intmonth == 4 || intmonth == 6 || intmonth == 9 || intmonth == 11)
                {
                    //30日期Picker
                    Picker(selection: $selectedDay2, label: Text("")
    ) {
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
                    .onChange(of: selectedDay2, perform: { value in

                    })

      
                }
                
                if (intmonth == 1 || intmonth == 3 || intmonth == 5 || intmonth == 7 || intmonth == 8 || intmonth == 10 || intmonth == 12)
                {
                    //31日期Picker
                    Picker(selection: $selectedDay2, label: Text("")
       ) {
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
                    .onChange(of: selectedDay2, perform: { value in


                    })

                }
            }
            .frame(height: (WKInterfaceDevice.current().screenBounds.size.width == 184.0) ? 55.0 : 50.0)



            Button(action: {
                self.ischoosesolor.toggle()
            }) {
                    Label(ischoosesolor ? "输入为:公历" : "输入为:农历", systemImage: "cursorarrow.click.badge.clock")
                        .foregroundColor(.black)
                    
                }
                .frame(height: 30.0)
                .background(ischoosesolor ? Color("cuteblue2") : Color("cuteyellow2"))
                .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
 
        }
        
    }
}
