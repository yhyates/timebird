//
//  ComplicationController.swift
//  Timetime WatchKit Extension
//
//  Created by 杨恒一 on 2021/1/29.
//

import ClockKit
import SwiftUI
import LunarCore
let ratioyear = String(format: "%.3f", yearbug(year: yearfresh(), day: yeardayfresh(), hour: hourfresh()))
let ratiomonth = String(format: "%.3f", monthbug(year: yearfresh(), month: monthfresh(), day: monthdayfresh(), hour: hourfresh()))
let ratioweek = String(format: "%.3f", weekbug(day: weekfresh(), hour: hourfresh()))
let lunarday = "\(LunarCore.solarToLunar(yearfresh(), monthfresh(), monthdayfresh())["lunarDayName"]!)" as String
let lunaryear = "\(LunarCore.solarToLunar(yearfresh(), monthfresh(), monthdayfresh())["GanZhiYear"]!)" as String
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
let lunar_12pic2 = [
    "牛":"🐮",
    "虎":"🐯",
    "兔":"🐰",
    "龙":"🐲",
    "蛇":"🐍",
    "马":"🐴",
    "羊":"🐏",
    "猴":"🐵",
    "鸡":"🐔",
    "狗":"🐶",
    "猪":"🐷",
    "鼠":"🐭",
]
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
let lunarpic = lunar_12pic[Calendar.current.component(.hour, from: Date())]!
let lunarmoonpic = lunar_moonpic[lunarday]!

let lunarzodic = "\(LunarCore.solarToLunar(yearfresh(), monthfresh(), monthdayfresh())["zodiac"]!)" as String
let lunarpic2 = lunar_12pic2[lunarzodic]!
let originlunar = "\(lunar())"
let startIndex =  originlunar.index(originlunar.endIndex, offsetBy: -2)
let hourlunar = String(originlunar[startIndex..<originlunar.endIndex])
var todaydata: String {
    UserDefaults.standard.string(forKey: "\(yeardayfresh())") ?? "0.0"
}
struct clockk: View {
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading){
                    Text("\(ratioyear)%")
                        .font(.system(size:13))
                        .foregroundColor(Color("cutegreen3"))
                    Text("\(ratiomonth)%")
                        .font(.system(size:13))
                        .foregroundColor(Color("cutegreen3"))
                    Text("\(ratioweek)%")
                        .font(.system(size:13))
                        .foregroundColor(Color("cutegreen3"))
                }
                Spacer()
                VStack{
                    Text("\(lunaryear)\(lunarpic2)")
                        .font(.system(size:13))
                    Text("\(lunarday)\(lunarmoonpic)")
                        .font(.system(size:13))
                    Text("\(hourlunar)\(lunarpic)")
                        .font(.system(size:13))
                }
                Spacer()
                HStack{
                    VStack{
                        Text("第")
                            .font(.system(size:13))
                            .foregroundColor(Color.white)
                        Text("第")
                            .font(.system(size:13))
                            .foregroundColor(Color.white)
                        Text("第")
                            .font(.system(size:13))
                            .foregroundColor(Color.white)
                    }
                    VStack{
                        Text("\(yeardayfresh())")
                            .font(.system(size:13))
                            .foregroundColor(Color.white)
                        Text("\(monthfresh())")
                            .font(.system(size:13))
                            .foregroundColor(Color.white)
                        Text("\(weekofmonthfresh())")
                            .font(.system(size:13))
                            .foregroundColor(Color.white)
                    }
                    .padding(.horizontal, -5.0)
                    VStack{
                        Text("天")
                            .font(.system(size:13))
                            .foregroundColor(Color.white)
                        Text("月")
                            .font(.system(size:13))
                            .foregroundColor(Color.white)
                        Text("周")
                            .font(.system(size:13))
                            .foregroundColor(Color.white)
                    }
                    
                }
                
            }
            ZStack{
                Text("今日循环时长：\(todaydata)分钟")
                    .font(.system(size:13))
                    .foregroundColor(Color("cutepurple"))
                
                //阳历节日
                let ifsoloarfestival = LunarCore.solarToLunar(yearfresh(), monthfresh(), monthdayfresh())["solarFestival"]
                if String(reflecting: ifsoloarfestival) != "\(String(describing: Optional("")))" {
                    HStack(alignment: .center) {
                        Spacer()
                        Image(systemName: "bell.badge")
                            .foregroundColor(Color("cutepurple"))
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
                        Text("今天:   \(LunarCore.solarToLunar(yearfresh(), monthfresh(), monthdayfresh())["lunarFestival"]!)" as String)
                            .foregroundColor(Color.white)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .lineLimit(1)
                        Spacer()
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
                        Text("今天:   \(LunarCore.solarToLunar(yearfresh(), monthfresh(), monthdayfresh())["term"]!)" as String)
                            .foregroundColor(Color.white)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .lineLimit(1)
                        Spacer()
                    }
                    .padding(.vertical, 1.0)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.black/*@END_MENU_TOKEN@*/)
                }
            }
        }
    }
}


class ComplicationController: NSObject, CLKComplicationDataSource {
    func getComplicationDescriptors(handler: @escaping ([CLKComplicationDescriptor]) -> Void) {
        let descriptors = [
            CLKComplicationDescriptor(identifier: "complication", displayName: "时鸟·Timebird", supportedFamilies: CLKComplicationFamily.allCases)
        ]
        handler(descriptors)
    }
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        //handler([.forward, .backward])
        handler([.forward])
        //handler([])
    }
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(Date().addingTimeInterval(24.0 * 60.0 * 60.0))
    }
    
    func handleSharedComplicationDescriptors(_ complicationDescriptors: [CLKComplicationDescriptor]) {
    }
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    func getCurrentTimelineEntry(
        for complication: CLKComplication,
        withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void)
    {
        let entry: CLKComplicationTimelineEntry
        
        switch complication.family {
        case .circularSmall://完成
            let image = CLKImageProvider(onePieceImage: UIImage(named: "icon")!)
            let template = CLKComplicationTemplateCircularSmallRingImage(imageProvider: image, fillFraction: 1.0, ringStyle: CLKComplicationRingStyle.closed)
            entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler (entry)
        case .extraLarge://待解决
            handler (nil)
        case .modularSmall://完成
            let image = CLKImageProvider(onePieceImage: UIImage(named: "icon")!)
            image.tintColor = UIColor(Color("cuteyellow2"))
            let template = CLKComplicationTemplateModularSmallRingImage(imageProvider: image, fillFraction: 1.0, ringStyle: CLKComplicationRingStyle.closed)
            template.tintColor = UIColor(Color.green)
            entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler (entry)
        case .modularLarge://完成
            let right1 = CLKSimpleTextProvider(text: " \(lunaryear)\(lunarpic2)")
            let right2 = CLKSimpleTextProvider(text: " \(lunarday)\(lunarmoonpic)")
            let right3 = CLKSimpleTextProvider(text: " \(hourlunar)\(lunarpic)")
            right1.tintColor = UIColor(Color("cutegray"))
            right2.tintColor = UIColor(Color("cutegray"))
            right3.tintColor = UIColor(Color("cutegray"))
            let image1 = CLKImageProvider(onePieceImage: UIImage(systemName: "y.circle")!)
            let image2 = CLKImageProvider(onePieceImage: UIImage(systemName: "m.circle")!)
            let image3 = CLKImageProvider(onePieceImage: UIImage(systemName: "w.circle")!)
            image1.tintColor = UIColor(Color("cutegray"))
            image2.tintColor = UIColor(Color("cutegray"))
            image3.tintColor = UIColor(Color("cutegray"))
            let template = CLKComplicationTemplateModularLargeColumns(row1ImageProvider: image1, row1Column1TextProvider: CLKSimpleTextProvider(text: "\(ratioyear)%"), row1Column2TextProvider: right1, row2ImageProvider: image2, row2Column1TextProvider: CLKSimpleTextProvider(text: "\(ratiomonth)%"), row2Column2TextProvider: right2, row3ImageProvider: image3, row3Column1TextProvider: CLKSimpleTextProvider(text: "\(ratioweek)%"), row3Column2TextProvider: right3)
            template.column2Alignment = .leading
            template.tintColor = UIColor(Color("cutegreen3"))
            entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler (entry)
        case .utilitarianSmall://完成
            let image = CLKImageProvider(onePieceImage: UIImage(named: "icon")!)
            let template = CLKComplicationTemplateUtilitarianSmallRingImage(imageProvider: image, fillFraction: 1.0, ringStyle: CLKComplicationRingStyle.closed)
            entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler (entry)
        case .utilitarianSmallFlat://完成
            let text = CLKSimpleTextProvider(text: "时鸟")
            let template = CLKComplicationTemplateUtilitarianSmallFlat(textProvider: text)
            entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler (entry)
        case .utilitarianLarge://完成
            let text = CLKSimpleTextProvider(text: "时鸟·Timebird")
            let template = CLKComplicationTemplateUtilitarianLargeFlat(textProvider: text)
            entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler (entry)
        case .graphicCorner://完成
            let image = CLKFullColorImageProvider(fullColorImage: UIImage(named: "icon")!)
            let template = CLKComplicationTemplateGraphicCornerCircularImage(imageProvider: image)
            entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler (entry)
        case .graphicCircular://完成
            let image = CLKFullColorImageProvider(fullColorImage: UIImage(named: "icon")!)
            let template = CLKComplicationTemplateGraphicCircularImage(imageProvider: image)
            entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler (entry)
        case .graphicBezel://完成
            let image = CLKFullColorImageProvider(fullColorImage: UIImage(named: "icon")!)
            let circulartemplate = CLKComplicationTemplateGraphicCircularImage(imageProvider: image)
            let text = CLKSimpleTextProvider(text: "时鸟")
            let template = CLKComplicationTemplateGraphicBezelCircularText(circularTemplate: circulartemplate, textProvider: text)
            entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler (entry)
        case .graphicRectangular:
            let template = CLKComplicationTemplateGraphicRectangularFullView(clockk())
            entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler (entry)
            
        default:
            handler (nil)
        }
        
    }
    func getLocalizableSampleTemplate(
        for complication: CLKComplication,
        withHandler handler: @escaping (CLKComplicationTemplate?) -> Void)
    {
        switch complication.family {
        case .circularSmall:
            let image = CLKImageProvider(onePieceImage: UIImage(named: "icon")!)
            let template = CLKComplicationTemplateCircularSmallRingImage(imageProvider: image, fillFraction: 1.0, ringStyle: CLKComplicationRingStyle.closed)
            handler (template)
        case .extraLarge:
            handler (nil)
        case .modularSmall:
            let image = CLKImageProvider(onePieceImage: UIImage(named: "icon")!)
            image.tintColor = UIColor(Color("cuteyellow2"))
            let template = CLKComplicationTemplateModularSmallRingImage(imageProvider: image, fillFraction: 1.0, ringStyle: CLKComplicationRingStyle.closed)
            template.tintColor = UIColor(Color.green)
            handler (template)
        case .modularLarge:
            let right1 = CLKSimpleTextProvider(text: " 壬戌🐮")
            let right2 = CLKSimpleTextProvider(text: " 三月🌕")
            let right3 = CLKSimpleTextProvider(text: " 亥时🐷")
            right1.tintColor = UIColor(Color("cutegray"))
            right2.tintColor = UIColor(Color("cutegray"))
            right3.tintColor = UIColor(Color("cutegray"))
            let image1 = CLKImageProvider(onePieceImage: UIImage(systemName: "y.circle")!)
            let image2 = CLKImageProvider(onePieceImage: UIImage(systemName: "m.circle")!)
            let image3 = CLKImageProvider(onePieceImage: UIImage(systemName: "w.circle")!)
            image1.tintColor = UIColor(Color("cutegray"))
            image2.tintColor = UIColor(Color("cutegray"))
            image3.tintColor = UIColor(Color("cutegray"))
            let template = CLKComplicationTemplateModularLargeColumns(row1ImageProvider: image1, row1Column1TextProvider: CLKSimpleTextProvider(text: "21.883%"), row1Column2TextProvider: right1, row2ImageProvider: image2, row2Column1TextProvider: CLKSimpleTextProvider(text: "67.338%"), row2Column2TextProvider: right2, row3ImageProvider: image3, row3Column1TextProvider: CLKSimpleTextProvider(text: "98.214%"), row3Column2TextProvider: right3)
            template.column2Alignment = .leading
            template.tintColor = UIColor(Color("cutegreen3"))
            handler (template)
        case .utilitarianSmall:
            let image = CLKImageProvider(onePieceImage: UIImage(named: "icon")!)
            let template = CLKComplicationTemplateUtilitarianSmallRingImage(imageProvider: image, fillFraction: 1.0, ringStyle: CLKComplicationRingStyle.closed)
            handler (template)
        case .utilitarianSmallFlat:
            let text = CLKSimpleTextProvider(text: "时鸟")
            let template = CLKComplicationTemplateUtilitarianSmallFlat(textProvider: text)
            handler (template)
        case .utilitarianLarge:
            let text = CLKSimpleTextProvider(text: "时鸟·Timebird")
            let template = CLKComplicationTemplateUtilitarianLargeFlat(textProvider: text)
            handler (template)
        case .graphicCorner:
            let image = CLKFullColorImageProvider(fullColorImage: UIImage(named: "icon")!)
            let template = CLKComplicationTemplateGraphicCornerCircularImage(imageProvider: image)
            handler (template)
        case .graphicCircular:
            let image = CLKFullColorImageProvider(fullColorImage: UIImage(named: "icon")!)
            let template = CLKComplicationTemplateGraphicCircularImage(imageProvider: image)
            handler (template)
        case .graphicBezel:
            let image = CLKFullColorImageProvider(fullColorImage: UIImage(named: "icon")!)
            let circulartemplate = CLKComplicationTemplateGraphicCircularImage(imageProvider: image)
            let text = CLKSimpleTextProvider(text: "时鸟")
            let template = CLKComplicationTemplateGraphicBezelCircularText(circularTemplate: circulartemplate, textProvider: text)
            handler (template)
        case .graphicRectangular:
            let template = CLKComplicationTemplateGraphicRectangularFullView(clockk())
            handler (template)
            
        default:
            handler (nil)
        }
    }
    
    
    
}
struct ComplicationController_Previews: PreviewProvider {
    static var previews: some View {
        CLKComplicationTemplateGraphicRectangularFullView(ContentView()).previewContext()
    }
}
