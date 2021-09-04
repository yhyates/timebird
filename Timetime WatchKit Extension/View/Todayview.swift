//
//  todayview.swift
//  Timetime WatchKit Extension
//
//  Created by 杨恒一 on 2021/3/6.
//

import Foundation
import SwiftUI
import LunarCore
struct todayview: View {
    let lunar_12pic = [
        1:"🐮",
        2:"🐮",
        3:"🐯",
        4:"🐯",
        5:"🐰",
        6:"🐰",
        7:"🐲",
        8:"🐲",
        9:"🐍",
        10:"🐍",
        11:"🐴",
        12:"🐴",
        13:"🐏",
        14:"🐏",
        15:"🐵",
        16:"🐵",
        17:"🐔",
        18:"🐔",
        19:"🐶",
        20:"🐶",
        21:"🐷",
        22:"🐷",
        23:"🐭",
        0:"🐭",
    ]
    @State var lunarpic = ""
    @State var lunarhour = ""

    var body: some View {
        
        VStack{
            HStack(alignment: .center){
            VStack(spacing:-3){
                Text("\("\(yearfresh())"[0..<1])")
                    .font(.system(size:12))
                    .foregroundColor(Color.white)
                Text("\("\(yearfresh())"[1..<2])")
                    .font(.system(size:12))
                    .foregroundColor(Color.white)
                Text("\("\(yearfresh())"[2..<3])")
                    .font(.system(size:12))
                    .foregroundColor(Color.white)
                Text("\("\(yearfresh())"[3..<4])")
                    .font(.system(size:12))
                    .foregroundColor(Color.white)
            }
            .padding(.leading)
            VStack(alignment: .center){
                Text("\(monthdayfresh())")
                    .fontWeight(.regular)
                    .foregroundColor(.white)
                    .font(.callout)
                    .frame(width: 27.0, height: 27.0)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("cutegreen3")/*@END_MENU_TOKEN@*/)
                    .cornerRadius(50.0)
                    .padding(EdgeInsets(top: 10.0, leading: 0.0, bottom: 2.0, trailing: 10.0))
                
                Text("\(monthfresh())月")
                    .font(.footnote)
                    .foregroundColor(Color.white)
                    .padding(.bottom, 9.0)
                    .padding(EdgeInsets(top: 0.0, leading: 0.0, bottom: 2.0, trailing: 10.0))
                    .frame(width: 40.0)
            }
            Spacer()
            VStack(alignment: .center){
                Text("\(lunarpic)")
                .font((WKInterfaceDevice.current().screenBounds.size.width == 156.0) ? .title3 : .title2)

                Text("\(lunarhour)")
                    .font((WKInterfaceDevice.current().screenBounds.size.width == 156.0) ? .footnote : .caption)
                    //.font(.custom("XianErTi", size: 18, relativeTo: .body))
                    //.fontWeight(.heavy)
                    .fontWeight(.bold)
                    .foregroundColor(Color("cutepurple"))
            }
            Spacer()
            
            VStack(alignment: .center){
                Text("\(LunarCore.solarToLunar(yearfresh(), monthfresh(), monthdayfresh())["lunarDayName"]!)" as String)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .font(.footnote)
                    .frame(width: 27.0, height: 27.0)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("cutegreen3")/*@END_MENU_TOKEN@*/)
                    .cornerRadius(50.0)
                    .padding(EdgeInsets(top: 10.0, leading: 10.0, bottom: 2.0, trailing: 0.0))
                
                Text("\(LunarCore.solarToLunar(yearfresh(), monthfresh(), monthdayfresh())["lunarMonthName"]!)" as String)
                    .font(.footnote)
                    .foregroundColor(Color.white)
                    .padding(.bottom, 9.0)
                    .padding(EdgeInsets(top: 0.0, leading: 10.0, bottom: 2.0, trailing: 0.0))
                    .frame(width: 40.0)
            }
            VStack(spacing:-3){
                Text("\(LunarCore.solarToLunar(yearfresh(), monthfresh(), monthdayfresh())["GanZhiYear"]!)"[0..<1] as String)
                    .font(.system(size:12))
                    .foregroundColor(Color.white)
                Text("\(LunarCore.solarToLunar(yearfresh(), monthfresh(), monthdayfresh())["GanZhiYear"]!)"[1..<2] as String)
                    .font(.system(size:12))
                    .foregroundColor(Color.white)
                Text("\(LunarCore.solarToLunar(yearfresh(), monthfresh(), monthdayfresh())["zodiac"]!)" as String)
                    .font(.system(size:12))
                    .foregroundColor(Color.white)
                Text("年")
                    .font(.system(size:12))
                    .foregroundColor(Color.white)
            }
            .padding(.trailing)
            
        }
        .frame(height: 69.0)
        }
        //.background(Color("gray3"))
        .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
            //分割线
            //Divider()
        
        HStack(alignment: .center){
            VStack(alignment: .center){
                Text("本年：第")
                    .font(.system(size:12))
                    .foregroundColor(Color.white)
                Text("本月：第")
                    .font(.system(size:12))
                    .foregroundColor(Color.white)
            }
            VStack(alignment: .center){
                Text("\(yeardayfresh())")
                    .font(.system(size:12))
                    .foregroundColor(Color.white)
                Text("\(monthdayfresh())")
                    .font(.system(size:12))
                    .foregroundColor(Color.white)
            }
            VStack(alignment: .center){
                Text("天，第")
                    .font(.system(size:12))
                    .foregroundColor(Color.white)
                Text("天，第")
                    .font(.system(size:12))
                    .foregroundColor(Color.white)
            }
            VStack(alignment: .center){
                Text("\(weekofyearfresh())")
                    .font(.system(size:12))
                    .foregroundColor(Color.white)
                Text("\(weekofmonthfresh())")
                    .font(.system(size:12))
                    .foregroundColor(Color.white)
            }
            VStack(alignment: .center){
                Text("周")
                    .font(.system(size:12))
                    .foregroundColor(Color.white)
                Text("周")
                    .font(.system(size:12))
                    .foregroundColor(Color.white)
            }
        }
        //.background(Color("gray2"))
        .cornerRadius(/*@START_MENU_TOKEN@*/6.0/*@END_MENU_TOKEN@*/)
        .onAppear{
            self.lunarpic = lunar_12pic[Calendar.current.component(.hour, from: Date())]!
            let originlunar = "\(lunar())"
            let startIndex =  originlunar.index(originlunar.endIndex, offsetBy: -2)
            let hourlunar = String(originlunar[startIndex..<originlunar.endIndex])
            self.lunarhour = hourlunar
        }
        .onReceive(NotificationCenter.default.publisher(for: WKExtension.applicationDidBecomeActiveNotification)
        ) { _ in
            self.lunarpic = lunar_12pic[Calendar.current.component(.hour, from: Date())]!
            let originlunar = "\(lunar())"
            let startIndex =  originlunar.index(originlunar.endIndex, offsetBy: -2)
            let hourlunar = String(originlunar[startIndex..<originlunar.endIndex])
            self.lunarhour = hourlunar
        }
  
        
        
        
        
        
    }
}


extension PreviewDevice {
    static let watch3_38 = PreviewDevice(rawValue: "Apple Watch Series 3 - 38mm")
    static let watch3_42 = PreviewDevice(rawValue: "Apple Watch Series 3 - 42mm")
    static let watch4_40 = PreviewDevice(rawValue: "Apple Watch Series 4 - 40mm")
    static let watch4_44 = PreviewDevice(rawValue: "Apple Watch Series 4 - 44mm")
    static let watch5_40 = PreviewDevice(rawValue: "Apple Watch Series 5 - 40mm")
    static let watch5_44 = PreviewDevice(rawValue: "Apple Watch Series 5 - 44mm")
}

struct AppleWatch5_40: ViewModifier {
    func body(content: _ViewModifier_Content<AppleWatch5_40>) -> some View {
        content
            .previewDevice(.watch5_40)
            .previewDisplayName("Series 5 40mm")
    }
}
struct AppleWatch5_44: ViewModifier {
    func body(content: _ViewModifier_Content<AppleWatch5_44>) -> some View {
        content
            .previewDevice(.watch4_44)
            .previewDisplayName("Series 5 44mm")
    }
}
//struct TimerView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            todayview()
//                .modifier(AppleWatch5_40())
//            todayview()
//                .modifier(AppleWatch5_44())
//        }
//    }
//}

struct todayview_Previews: PreviewProvider {
    static var previews: some View {
        todayview()
    }
}
