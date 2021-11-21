//
//  Todo.swift
//  Timetime WatchKit Extension
//
//  Created by 杨恒一 on 2021/3/14.
//

import Foundation
import SwiftUI

struct todoView: View {
    let thing1 = UserDefaults.standard.string(forKey: "thing1")
    @State var five1 = ""
    let thing2 = UserDefaults.standard.string(forKey: "thing2")
    @State var five2 = ""
    let thing3 = UserDefaults.standard.string(forKey: "thing3")
    @State var five3 = ""
    let thing4 = UserDefaults.standard.string(forKey: "thing4")
    @State var five4 = ""
    let thing5 = UserDefaults.standard.string(forKey: "thing5")
    @State var five5 = ""
    @State var counter:Int = 0
    let thingnum1 = UserDefaults.standard.integer(forKey: "thingnum1")
    @State var num1 = 0
    let thingnum2 = UserDefaults.standard.integer(forKey: "thingnum2")
    @State var num2 = 0
    let thingnum3 = UserDefaults.standard.integer(forKey: "thingnum3")
    @State var num3 = 0
    let thingnum4 = UserDefaults.standard.integer(forKey: "thingnum4")
    @State var num4 = 0
    let thingnum5 = UserDefaults.standard.integer(forKey: "thingnum5")
    @State var num5 = 0

    var body: some View {
        
        ZStack{
            ScrollView(showsIndicators: false){
                Text("Today, give me 🖐⁵!")
                    .frame(width: WKInterfaceDevice.current().screenBounds.size.width, height: 30.0)
                    .foregroundColor(Color.black)
                    //.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("cutegreen2")/*@END_MENU_TOKEN@*/)
                    .cornerRadius(20.0)
                    .background(LinearGradient(gradient: Gradient(colors: [Color("cuteblue2"), Color("cutepurple")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                    .cornerRadius(20.0)
                HStack{
                    TextField("\(five1)", text: $five1)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("gray2")/*@END_MENU_TOKEN@*/)
                        .cornerRadius(9.0)
                        .padding(.leading)
                        .multilineTextAlignment(TextAlignment.center)
                        .lineLimit(1)
                        .font(.caption2)
                        .onChange(of: five1, perform: { value in
                            UserDefaults.standard.set(five1, forKey: "thing1")
                        })
                        .onAppear{
                            if (thing1 == nil) {
                                if five1 == "" {
                                    self.five1 = "请输入事项："
                                }
                            }
                            else {
                                if five1 != "" {
                                    if (five1 != "请输入")&&(thing1 != "🎉已完成🎉")&&(five1 != "🎉已完成🎉")&&(five1 == thing1) {
                                    self.five1 = thing1 ?? "请输入事项："
                                    }
                                } else {
                                    if (five1 != "请输入")&&(thing1 != "🎉已完成🎉")&&(five1 != "🎉已完成🎉") {
                                    self.five1 = thing1 ?? "请输入事项："
                                    }
                                }
                            }
         
                        }
                    Spacer()
                    HStack{
                        Text("✔︎")
                        VStack{
                            Text("1")
                                .font(.system(size:12))
                                .fontWeight(.bold)
                            Text((num1 != 0) ? "\(num1)" : "")
                                .font(.system(size:10))
                                .foregroundColor(Color.yellow)
                        }
                    }
                    .onTapGesture {
                        if self.five1 != "🎉已完成🎉" {
                            WKInterfaceDevice.current().play(.success)
                            self.five1 = "🎉已完成🎉"
                            counter += 1
                            UserDefaults.standard.set(five1, forKey: "thing1")
                        }
                        self.num1 = 0
                        UserDefaults.standard.set(0, forKey: "thingnum1")
                    }
                    .onLongPressGesture {
                        if self.five1 != "🎉已完成🎉" {
                            WKInterfaceDevice.current().play(.click)
                            self.num1 += 1
                            UserDefaults.standard.set(num1, forKey: "thingnum1")
                        }
                    }
                    .onChange(of: num1, perform: { value in
                        UserDefaults.standard.set(num1, forKey: "thingnum1")
                    })
                    .onAppear{
                        if (num1 == 0)&&(five1 != "🎉已完成🎉") {
                            self.num1 = thingnum1
                        }
                        if (thingnum1 != 0){
                            if num1 == thingnum1 {
                                self.num1 = thingnum1
                            }
                        }
                    }
                    .frame(width: 30.0)
                }

                //2
                HStack{
                    TextField("\(five2)", text: $five2)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("gray2")/*@END_MENU_TOKEN@*/)
                        .cornerRadius(9.0)
                        .padding(.leading)
                        .multilineTextAlignment(TextAlignment.center)
                        .lineLimit(1)
                        .font(.caption2)
                        .onChange(of: five2, perform: { value in
                            UserDefaults.standard.set(five2, forKey: "thing2")
                        })
                        .onAppear{
                            if (thing2 == nil) {
                                if five2 == "" {
                                    self.five2 = "请输入事项："
                                }
                            }
                            else {
                                if five2 != "" {
                                    if (five2 != "请输入")&&(thing2 != "🎉已完成🎉")&&(five2 != "🎉已完成🎉")&&(five2 == thing2) {
                                    self.five2 = thing2 ?? "请输入事项："
                                    }
                                } else {
                                    if (five2 != "请输入")&&(thing2 != "🎉已完成🎉")&&(five2 != "🎉已完成🎉") {
                                    self.five2 = thing2 ?? "请输入事项："
                                    }
                                }
                            }
                            
                        }
                    Spacer()
                    HStack{
                        Text("✔︎")
                        VStack{
                            Text("2")
                                .font(.system(size:12))
                                .fontWeight(.bold)
                            Text((num2 != 0) ? "\(num2)" : "")
                                .font(.system(size:10))
                                .foregroundColor(Color.yellow)
                        }
                    }
                    .onTapGesture {
                        if self.five2 != "🎉已完成🎉" {
                            WKInterfaceDevice.current().play(.success)
                            self.five2 = "🎉已完成🎉"
                            counter += 1
                            UserDefaults.standard.set(five2, forKey: "thing2")
                        }
                        self.num2 = 0
                        UserDefaults.standard.set(0, forKey: "thingnum2")
                    }
                    .onLongPressGesture {
                        if self.five2 != "🎉已完成🎉" {
                            WKInterfaceDevice.current().play(.click)
                            self.num2 += 1
                            UserDefaults.standard.set(num2, forKey: "thingnum2")
                        }
                    }
                    .onChange(of: num2, perform: { value in
                        UserDefaults.standard.set(num2, forKey: "thingnum2")
                    })
                    .onAppear{
                        if (num2 == 0)&&(five2 != "🎉已完成🎉") {
                            self.num2 = thingnum2
                        }
                        if (thingnum2 != 0){
                            if num2 == thingnum2 {
                                self.num2 = thingnum2
                            }
                        }
                    }
                    .frame(width: 30.0)
                }
                //3
                HStack{
                    TextField("\(five3)", text: $five3)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("gray2")/*@END_MENU_TOKEN@*/)
                        .cornerRadius(9.0)
                        .padding(.leading)
                        .multilineTextAlignment(TextAlignment.center)
                        .lineLimit(1)
                        .font(.caption2)
                        .onChange(of: five3, perform: { value in
                            UserDefaults.standard.set(five3, forKey: "thing3")
                        })
                        .onAppear{
                            if (thing3 == nil) {
                                if five3 == "" {
                                    self.five3 = "请输入事项："
                                }
                            }
                            else {
                                if five3 != "" {
                                    if (five3 != "请输入")&&(thing3 != "🎉已完成🎉")&&(five3 != "🎉已完成🎉")&&(five3 == thing3) {
                                    self.five3 = thing3 ?? "请输入事项："
                                    }
                                } else {
                                    if (five3 != "请输入")&&(thing3 != "🎉已完成🎉")&&(five3 != "🎉已完成🎉") {
                                    self.five3 = thing3 ?? "请输入事项："
                                    }
                                }
                            }
                            
                        }
                    Spacer()
                    HStack{
                        Text("✔︎")
                        VStack{
                            Text("3")
                                .font(.system(size:12))
                                .fontWeight(.bold)
                            Text((num3 != 0) ? "\(num3)" : "")
                                .font(.system(size:10))
                                .foregroundColor(Color.yellow)
                        }
                    }
                    .onTapGesture {
                        if self.five3 != "🎉已完成🎉" {
                            WKInterfaceDevice.current().play(.success)
                            self.five3 = "🎉已完成🎉"
                            counter += 1
                            UserDefaults.standard.set(five3, forKey: "thing3")
                        }
                        self.num3 = 0
                        UserDefaults.standard.set(0, forKey: "thingnum3")
                    }
                    .onLongPressGesture {
                        if self.five3 != "🎉已完成🎉" {
                            WKInterfaceDevice.current().play(.click)
                            self.num3 += 1
                            UserDefaults.standard.set(num3, forKey: "thingnum3")
                        }
                    }
                    .onChange(of: num3, perform: { value in
                        UserDefaults.standard.set(num3, forKey: "thingnum3")
                    })
                    .onAppear{
                        if (num3 == 0)&&(five3 != "🎉已完成🎉") {
                            self.num3 = thingnum3
                        }
                        if (thingnum3 != 0){
                            if num3 == thingnum3 {
                                self.num3 = thingnum3
                            }
                        }
                    }
                    .frame(width: 30.0)
                }
                //4
                HStack{
                    TextField("\(five4)", text: $five4)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("gray2")/*@END_MENU_TOKEN@*/)
                        .cornerRadius(9.0)
                        .padding(.leading)
                        .multilineTextAlignment(TextAlignment.center)
                        .lineLimit(1)
                        .font(.caption2)
                        .onChange(of: five4, perform: { value in
                            UserDefaults.standard.set(five4, forKey: "thing4")
                        })
                        .onAppear{
                            if (thing4 == nil) {
                                if five4 == "" {
                                    self.five4 = "请输入事项："
                                }
                            }
                            else {
                                if five4 != "" {
                                    if (five4 != "请输入")&&(thing4 != "🎉已完成🎉")&&(five4 != "🎉已完成🎉")&&(five4 == thing4) {
                                    self.five4 = thing4 ?? "请输入事项："
                                    }
                                } else {
                                    if (five4 != "请输入")&&(thing4 != "🎉已完成🎉")&&(five4 != "🎉已完成🎉") {
                                    self.five4 = thing4 ?? "请输入事项："
                                    }
                                }
                            }
                            
                        }
                    Spacer()
                    HStack{
                        Text("✔︎")
                        VStack{
                            Text("4")
                                .font(.system(size:12))
                                .fontWeight(.bold)
                            Text((num4 != 0) ? "\(num4)" : "")
                                .font(.system(size:10))
                                .foregroundColor(Color.yellow)
                        }
                    }
                    .onTapGesture {
                        if self.five4 != "🎉已完成🎉" {
                            WKInterfaceDevice.current().play(.success)
                            self.five4 = "🎉已完成🎉"
                            counter += 1
                            UserDefaults.standard.set(five4, forKey: "thing4")
                        }
                        self.num4 = 0
                        UserDefaults.standard.set(0, forKey: "thingnum4")
                    }
                    .onLongPressGesture {
                        if self.five4 != "🎉已完成🎉" {
                            WKInterfaceDevice.current().play(.click)
                            self.num4 += 1
                            UserDefaults.standard.set(num4, forKey: "thingnum4")
                        }
                    }
                    .onChange(of: num4, perform: { value in
                        UserDefaults.standard.set(num4, forKey: "thingnum4")
                    })
                    .onAppear{
                        if (num4 == 0)&&(five4 != "🎉已完成🎉") {
                            self.num4 = thingnum4
                        }
                        if (thingnum4 != 0){
                            if num4 == thingnum4 {
                                self.num4 = thingnum4
                            }
                        }
                    }
                    .frame(width: 30.0)
                }
                //5
                HStack{
                    TextField("\(five5)", text: $five5)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("gray2")/*@END_MENU_TOKEN@*/)
                        .cornerRadius(9.0)
                        .padding(.leading)
                        .multilineTextAlignment(TextAlignment.center)
                        .lineLimit(1)
                        .font(.caption2)
                        .onChange(of: five5, perform: { value in
                            UserDefaults.standard.set(five5, forKey: "thing5")
                        })
                        .onAppear{
                            if (thing5 == nil) {
                                if five5 == "" {
                                    self.five5 = "请输入事项："
                                }
                            }
                            else {
                                if five5 != "" {
                                    if (five5 != "请输入")&&(thing5 != "🎉已完成🎉")&&(five5 != "🎉已完成🎉")&&(five5 == thing5) {
                                    self.five5 = thing5 ?? "请输入事项："
                                    }
                                } else {
                                    if (five5 != "请输入")&&(thing5 != "🎉已完成🎉")&&(five5 != "🎉已完成🎉") {
                                    self.five5 = thing5 ?? "请输入事项："
                                    }
                                }
                            }
                            
                        }
                    Spacer()
                    HStack{
                        Text("✔︎")
                        VStack{
                            Text("5")
                                .font(.system(size:12))
                                .fontWeight(.bold)
                            Text((num5 != 0) ? "\(num5)" : "")
                                .font(.system(size:10))
                                .foregroundColor(Color.yellow)
                        }
                    }
                    .onTapGesture {
                        if self.five5 != "🎉已完成🎉" {
                            WKInterfaceDevice.current().play(.success)
                            self.five5 = "🎉已完成🎉"
                            counter += 1
                            UserDefaults.standard.set(five5, forKey: "thing5")
                        }
                        self.num5 = 0
                        UserDefaults.standard.set(0, forKey: "thingnum5")
                    }
                    .onLongPressGesture {
                        if self.five5 != "🎉已完成🎉" {
                            WKInterfaceDevice.current().play(.click)
                            self.num5 += 1
                            UserDefaults.standard.set(num5, forKey: "thingnum5")
                        }
                    }
                    .onChange(of: num5, perform: { value in
                        UserDefaults.standard.set(num5, forKey: "thingnum5")
                    })
                    .onAppear{
                        if (num5 == 0)&&(five5 != "🎉已完成🎉") {
                            self.num5 = thingnum5
                        }
                        if (thingnum5 != 0){
                            if num5 == thingnum5 {
                                self.num5 = thingnum5
                            }
                        }
                    }
                    .frame(width: 30.0)
                }
                
            }//sc
            .navigationTitle("📝Todo清单")
            .navBarTitleDisplayMode(.inline)

        
            
            ConfettiCannon(counter: $counter, num: 15,  confettis: [.text("🌟")], openingAngle: Angle(degrees: 40), closingAngle: Angle(degrees: 360), radius: 200, repetitions: 3, repetitionInterval: 0.1)
        }//zs
        
    }
}
