//
//  record.swift
//  Timetime WatchKit Extension
//
//  Created by 杨恒一 on 2021/4/13.
//

import Foundation
import SwiftUI
import LunarCore

//let content = UNMutableNotificationContent()
//content.title = "\()提醒：\()"
//content.sound = UNNotificationSound.defaultCritical
//let trigger = UNTimeIntervalNotificationTrigger(timeInterval: (60), repeats: true)
//let request = UNNotificationRequest(identifier: "\()", content: content, trigger: trigger)
//UNUserNotificationCenter.current().add(request)
struct AddRecord: View {
    static let DefaultWho = "null"
    static let Defaulticon = "✨"
    @State var who = ""
    @State var icon = ""
    @State var releaseDate = Date()
    @State private var isedit = true
    @State var isnoti = false
    let onComplete: (String, String, Date) -> Void
    //Picker转换
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        //formatter.dateStyle = .short
        formatter.dateFormat = "yyyy年MM月dd日"
        return formatter
    }
    @State private var selectedtype = 0
    @State private var selectedhour = 7
    @State private var selectedmin = 30
    var type = ["每天", "每周", "每月"]
    var hour = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12","13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "0"]
    var min = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12","13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24","25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"]
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                HStack{
                    TextField("✨", text: $icon)
                        .frame(width: 38.0)
                    Spacer()
                    //Separator()
                    TextField("记录习惯...", text: $who)
                }
                .padding(.vertical, 15.0)
                
                //                Button(action: {
                //                    withAnimation(Animation.easeInOut(duration: 1)) {
                //                        self.isnoti.toggle()
                //                    }
                //
                //                }) {
                //                    Toggle(isOn: $isnoti) {
                //                        Text("通知提醒")
                //                    }
                //                }
                //                .padding([.top, .leading, .trailing])
                //                if isnoti {
                //                    HStack {
                //                        Picker(selection: $selectedtype, label: Text("重复")
                //                                .font(.subheadline)
                //                                .fontWeight(.light)
                //                                .foregroundColor(Color.black)
                //                                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.green/*@END_MENU_TOKEN@*/)
                //                                .cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)) {
                //                            ForEach(0 ..< type.count) {
                //                                Text(self.type[$0]).multilineTextAlignment(.center).frame(width: 45.0).tag($0)
                //                                //设置40宽度使40mm下正常显示
                //                            }
                //                        }
                //                        .foregroundColor(Color.green)
                //
                //                        Picker(selection: $selectedhour, label: Text("时")
                //                                .font(.subheadline)
                //                                .fontWeight(.light)
                //                                .foregroundColor(Color.black)
                //                                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.green/*@END_MENU_TOKEN@*/)
                //                                .cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)) {
                //                            ForEach(0 ..< hour.count) {
                //                                Text(self.hour[$0]).multilineTextAlignment(.center).frame(width: 45.0).tag($0)
                //                                //设置40宽度使40mm下正常显示
                //                            }
                //                        }
                //                        .foregroundColor(Color.green)
                //                        .onChange(of: selectedmin, perform: { value in
                //
                //                        })
                //
                //                        Picker(selection: $selectedmin, label: Text("分")
                //                                .font(.subheadline)
                //                                .fontWeight(.light)
                //                                .foregroundColor(Color.black)
                //                                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.green/*@END_MENU_TOKEN@*/)
                //                                .cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)) {
                //
                //                            ForEach(0 ..< min.count) {
                //                                Text(self.min[$0]).tag($0)
                //                            }
                //                        }
                //                        .foregroundColor(Color.green)
                //                        .onChange(of: selectedhour, perform: { value in
                ////                            self.isedit = false
                ////                            let yearselceted =  Int(String(year[selectedtype]))
                ////                            let intyear = yearselceted!//int型年份
                ////                            let monthselceted =  Int(String(month[selectedhour]))
                ////                            let intmonth = monthselceted!//int型月份
                ////                            let dayselceted =  Int(String(day[selectedmin]))
                ////                            let intday = dayselceted!//int型日期
                ////                            let str = "\(intyear)年\(intmonth)月\(intday)日"
                ////                            self.releaseDate = dateFormatter.date(from: str)!
                //                        })
                //
                //                    }
                //                    .frame(height: 68.0)
                //
                //            }
                //
                Divider()
                    .padding(.vertical)
                Section {
                    Button(action: who.isEmpty ? {} : addMoveAction) {
                        Text("完成")
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
        self.releaseDate = Date()
        onComplete(
            who.isEmpty ? AddRecord.DefaultWho : who,
            icon.isEmpty ? AddRecord.Defaulticon : icon,
            releaseDate
        )
        WKInterfaceDevice.current().play(.success)
    }
    
}
struct inf2: View {
    @Binding var isPushed: Bool
    let recorders: Recorder
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        //formatter.dateStyle = .short
        formatter.dateFormat = "yyyy年MM月dd日HH:mm ss"
        return formatter
    }
    var dynamicrecord: Array<String> {
        UserDefaults.standard.stringArray(forKey: "Record-\(recorders.who!)") ?? [""]
    }
    var dynamiccolorrecord: Array<String> {
        UserDefaults.standard.stringArray(forKey: "Recordcolor-\(recorders.who!)") ?? [""]
    }
    @State var array:[String] = []
    @State var selected_color = "cutewhite"

    var body: some View {
        ScrollView(showsIndicators: false) {
            Button(action: {
                WKInterfaceDevice.current().play(.start)
                let recordArray = (dynamicrecord == [""]) ? (["\(dateFormatter.string(from: Date()))"]) : (dynamicrecord + ["\(dateFormatter.string(from: Date()))"])
                UserDefaults.standard.set(recordArray, forKey: "Record-\(recorders.who!)")
                self.array.append("\(dateFormatter.string(from: Date()))")
                
                let recordcolorArray = (dynamiccolorrecord == [""]) ? (["\(selected_color)"]) : (dynamiccolorrecord + ["\(selected_color)"])
                UserDefaults.standard.set(recordcolorArray, forKey: "Recordcolor-\(recorders.who!)")
            }) {
                HStack{
                    Text("\(recorders.who!)")
                        .lineLimit(1)
                    Text("+1")
                        .font(.title3)
                }
            }
            .background((selected_color == "cutewhite") ? nil : Color("\(selected_color)"))
            .cornerRadius(20.0)


                HStack{
                    Circle()
                        .frame(width: (WKInterfaceDevice.current().screenBounds.size.width == 184.0) ? 30.0 : 27.0, height: (WKInterfaceDevice.current().screenBounds.size.width == 184.0) ? 30.0 : 27.0)
                        .foregroundColor(/*@START_MENU_TOKEN@*/Color("cutered")/*@END_MENU_TOKEN@*/)
                        .onTapGesture(perform: {
                            self.selected_color = "cutered"
                            WKInterfaceDevice.current().play(.click)
                        })
                    Circle()
                        .frame(width: (WKInterfaceDevice.current().screenBounds.size.width == 184.0) ? 30.0 : 27.0, height: (WKInterfaceDevice.current().screenBounds.size.width == 184.0) ? 30.0 : 27.0)
                        .foregroundColor(Color("cuteyellow"))
                        .onTapGesture(perform: {
                            self.selected_color = "cuteyellow"
                            WKInterfaceDevice.current().play(.click)
                        })
                    Circle()
                        //.frame(width: /*@START_MENU_TOKEN@*/30.0/*@END_MENU_TOKEN@*/, height: 30.0)
                        .frame(width: (WKInterfaceDevice.current().screenBounds.size.width == 184.0) ? 30.0 : 27.0, height: (WKInterfaceDevice.current().screenBounds.size.width == 184.0) ? 30.0 : 27.0)
                        .foregroundColor(/*@START_MENU_TOKEN@*/Color("cutegreen")/*@END_MENU_TOKEN@*/)
                        .onTapGesture(perform: {
                            self.selected_color = "cutegreen"
                            WKInterfaceDevice.current().play(.click)
                        })
                    Circle()
                        .frame(width: (WKInterfaceDevice.current().screenBounds.size.width == 184.0) ? 30.0 : 27.0, height: (WKInterfaceDevice.current().screenBounds.size.width == 184.0) ? 30.0 : 27.0)
                        .foregroundColor(Color("cuteblue"))
                        .onTapGesture(perform: {
                            self.selected_color = "cuteblue"
                            WKInterfaceDevice.current().play(.click)
                        })
                    Circle()
                        .frame(width: (WKInterfaceDevice.current().screenBounds.size.width == 184.0) ? 30.0 : 27.0, height: (WKInterfaceDevice.current().screenBounds.size.width == 184.0) ? 30.0 : 27.0)
                        .foregroundColor(Color("cutepurple2"))
                        .onTapGesture(perform: {
                            self.selected_color = "cutepurple2"
                            WKInterfaceDevice.current().play(.click)
                        })
                    
                }
            .padding(.top)
            
            
            //分割线
            Divider()
                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("cutegreen")/*@END_MENU_TOKEN@*/)
                .padding(.top, 5.0)
                .opacity(0.4)
            VStack{
                Text("\(dateFormatter.string(from: recorders.releaseDate!))")
                    .font(.footnote)
                    //.foregroundColor(Color("cutepurple"))
                Text("（创建时间）")
                    .font(.footnote)
            }
            Divider()
                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("cutegreen")/*@END_MENU_TOKEN@*/)
                .opacity(0.4)
            
            ForEach(array.indices, id: \.self) { index in
                VStack{
                Text("新增:").font(.footnote)//.foregroundColor(Color("cutegreen3"))
                Text(self.array[index]).font(.footnote)//.foregroundColor(Color("cutegreen3"))
                }.padding(.vertical, 3.0)
            }
            Text("历史记录:").font(.footnote)
                        
            ForEach(0 ..< dynamicrecord.count) {
                Text(self.dynamicrecord[$0]).font(.footnote).padding(.vertical, 3.0).foregroundColor(Color("\(self.dynamiccolorrecord[$0])"))
            }
                 
            if dynamicrecord.count != 0 {
            Button(action: {
                var dynamicrecord2 = UserDefaults.standard.stringArray(forKey: "Record-\(recorders.who!)") ?? [""]
                _ = dynamicrecord2.removeLast()
                UserDefaults.standard.set(dynamicrecord2, forKey: "Record-\(recorders.who!)")

               var dynamiccolorrecord2 = UserDefaults.standard.stringArray(forKey: "Recordcolor-\(recorders.who!)") ?? [""]
                _ = dynamiccolorrecord2.removeLast()
                UserDefaults.standard.set(dynamiccolorrecord2, forKey: "Recordcolor-\(recorders.who!)")
                
                isPushed = false

            }) {
                    Text("删除最近一次")
                        .font(.caption)
            }
            .cornerRadius(20.0)
            }

            if dynamicrecord.count != 0 {
            Button(action: {
//                var dynamicrecord2 = UserDefaults.standard.stringArray(forKey: "Record-\(recorders.who!)") ?? [""]
//                let newdynamicrecord = dynamicrecord2.removeLast()
                UserDefaults.standard.set([""], forKey: "Record-\(recorders.who!)")
//
//               var dynamiccolorrecord2 = UserDefaults.standard.stringArray(forKey: "Recordcolor-\(recorders.who!)") ?? [""]
//                let newdynamiccolorrecord = dynamiccolorrecord2.removeLast()
                UserDefaults.standard.set([""], forKey: "Recordcolor-\(recorders.who!)")
                
                var dynamicrecord2 = UserDefaults.standard.stringArray(forKey: "Record-\(recorders.who!)") ?? [""]
                _ = dynamicrecord2.removeLast()
                UserDefaults.standard.set(dynamicrecord2, forKey: "Record-\(recorders.who!)")

               var dynamiccolorrecord2 = UserDefaults.standard.stringArray(forKey: "Recordcolor-\(recorders.who!)") ?? [""]
                _ = dynamiccolorrecord2.removeLast()
                UserDefaults.standard.set(dynamiccolorrecord2, forKey: "Recordcolor-\(recorders.who!)")
                
                
                
                
                
                isPushed = false

            }) {
                    Text("清空")
                        .font(.caption)
                        .foregroundColor(Color.red)
            }
            .cornerRadius(20.0)
            }
            
            
            
            
            
            
            
        }

   
    }
}

struct RecordRow: View {
    let recorders: Recorder
    func dynamicrecordfunc(whoo: String) -> Int {
        var dynamicrecord: Array<String> {
            UserDefaults.standard.stringArray(forKey: "Record-\(whoo)") ?? [""]
        }
        if dynamicrecord == [""] {
            return 0
        } else {
            return dynamicrecord.count
        }
    }
    @State var nummm = 1
    @State var isPushed = false

    var body: some View {
        NavigationLink(destination: inf2(isPushed: $isPushed, recorders: recorders), isActive: $isPushed) {
            HStack{
                VStack(alignment: .leading){
                    Spacer()
                    recorders.icon.map(Text.init)
                        .frame(width: 24.0)
                        .font(.title3)
                        .lineLimit(1)
                        .fixedSize(horizontal: true, vertical: false)
                    Spacer()
                }
                Spacer()
                
                VStack(alignment: .center){
                    recorders.who.map(Text.init)
                        .font(.caption)
                        //.frame(width: 100.0)
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                Spacer()
                VStack(alignment: .leading){
                    Spacer()
                    recorders.who.map { _ in Text("\(nummm)次") }
                        .font(.caption)
                        .lineLimit(1)
                        .fixedSize(horizontal: true, vertical: false)
                    Spacer()
                }
                .onAppear{
                    self.nummm = dynamicrecordfunc(whoo: recorders.who!)

                    var dynamicrecord: Array<String> {
                        UserDefaults.standard.stringArray(forKey: "Record-\(recorders.who!)") ?? [""]
                    }
                    var dynamiccolorrecord: Array<String> {
                        UserDefaults.standard.stringArray(forKey: "Recordcolor-\(recorders.who!)") ?? [""]
                    }
                    
                    if dynamicrecord.count != dynamiccolorrecord.count {
                    let recordcolorArray = Array(repeating: "cutewhite", count: dynamicrecord.count)
                    UserDefaults.standard.set(recordcolorArray, forKey: "Recordcolor-\(recorders.who!)")
                    }
                }

            }
        }
    }
}
