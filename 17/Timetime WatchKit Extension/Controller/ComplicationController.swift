//
//  ComplicationController.swift
//  Timetime WatchKit Extension
//
//  Created by æ¨æä¸ on 2021/1/29.
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
    1:"đŽ",
    2:"đŽ",
    3:"đ¯",
    4:"đ¯",
    5:"đ°",
    6:"đ°",
    7:"đ˛",
    8:"đ˛",
    9:"đ",
    10:"đ",
    11:"đ´",
    12:"đ´",
    13:"đ",
    14:"đ",
    15:"đĩ",
    16:"đĩ",
    17:"đ",
    18:"đ",
    19:"đļ",
    20:"đļ",
    21:"đˇ",
    22:"đˇ",
    23:"đ­",
    0:"đ­",
]
let lunar_12pic2 = [
    "į":"đŽ",
    "č":"đ¯",
    "å":"đ°",
    "éž":"đ˛",
    "č":"đ",
    "éŠŦ":"đ´",
    "įž":"đ",
    "į´":"đĩ",
    "é¸Ą":"đ",
    "į":"đļ",
    "įĒ":"đˇ",
    "éŧ ":"đ­",
]
let lunar_moonpic = [
    "åä¸":"đ",
    "åäē":"đ",
    "åä¸":"đ",
    "åå":"đ",
    "åäē":"đ",
    "åå­":"đ",
    "åä¸":"đ",
    "ååĢ":"đ",
    "åäš":"đ",
    "åå":"đ",
    "åä¸":"đ",
    "åäē":"đ",
    "åä¸":"đ",
    "åå":"đ",
    "åäē":"đ",
    "åå­":"đ",
    "åä¸":"đ",
    "ååĢ":"đ",
    "åäš":"đ",
    "äēå":"đ",
    "åģŋä¸":"đ",
    "åģŋäē":"đ",
    "åģŋä¸":"đ",
    "åģŋå":"đ",
    "åģŋäē":"đ",
    "åģŋå­":"đ",
    "åģŋä¸":"đ",
    "åģŋåĢ":"đ",
    "åģŋäš":"đ",
    "ä¸å":"đ",
    
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
                        Text("įŦŦ")
                            .font(.system(size:13))
                            .foregroundColor(Color("cutepurple"))
                        Text("įŦŦ")
                            .font(.system(size:13))
                            .foregroundColor(Color("cutepurple"))
                        Text("įŦŦ")
                            .font(.system(size:13))
                            .foregroundColor(Color("cutepurple"))
                    }
                    VStack{
                        Text("\(yeardayfresh())")
                            .font(.system(size:13))
                            .foregroundColor(Color("cutepurple"))
                        Text("\(monthfresh())")
                            .font(.system(size:13))
                            .foregroundColor(Color("cutepurple"))
                        Text("\(weekofmonthfresh())")
                            .font(.system(size:13))
                            .foregroundColor(Color("cutepurple"))
                    }
                    .padding(.horizontal, -5.0)
                    VStack{
                        Text("å¤Š")
                            .font(.system(size:13))
                            .foregroundColor(Color("cutepurple"))
                        Text("æ")
                            .font(.system(size:13))
                            .foregroundColor(Color("cutepurple"))
                        Text("å¨")
                            .font(.system(size:13))
                            .foregroundColor(Color("cutepurple"))
                    }
                    
                }
                
            }
            ZStack{
                Text("äģæĨåžĒį¯æļéŋīŧ\(todaydata)åé")
                    .font(.system(size:13))
                    .foregroundColor(Color("cutepurple"))
                
                //éŗåčæĨ
                let ifsoloarfestival = LunarCore.solarToLunar(yearfresh(), monthfresh(), monthdayfresh())["solarFestival"]
                if String(reflecting: ifsoloarfestival) != "\(String(describing: Optional("")))" {
                    HStack(alignment: .center) {
                        Spacer()
                        Image(systemName: "bell.badge")
                            .foregroundColor(Color("cutepurple"))
                        Text("äģå¤Š:   \(LunarCore.solarToLunar(yearfresh(), monthfresh(), monthdayfresh())["solarFestival"]!)" as String)
                            .foregroundColor(Color.white)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .lineLimit(1)
                        Spacer()
                        
                    }
                    .padding(.vertical, 1.0)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.black/*@END_MENU_TOKEN@*/)
                }
                //é´åčæĨ
                let iffestival = LunarCore.solarToLunar(yearfresh(), monthfresh(), monthdayfresh())["lunarFestival"]
                if String(reflecting: iffestival) != "\(String(describing: Optional("")))" {
                    HStack(alignment: .center) {
                        Spacer()
                        Image(systemName: "bell.badge")
                            .foregroundColor(Color("cutepurple"))
                        Text("äģå¤Š:   \(LunarCore.solarToLunar(yearfresh(), monthfresh(), monthdayfresh())["lunarFestival"]!)" as String)
                            .foregroundColor(Color.white)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .lineLimit(1)
                        Spacer()
                    }
                    .padding(.vertical, 1.0)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.black/*@END_MENU_TOKEN@*/)
                }
                //čæ°
                let iflunar24 = LunarCore.solarToLunar(yearfresh(), monthfresh(), monthdayfresh())["term"]
                if String(reflecting: iflunar24) != "\(String(describing: Optional("")))" {
                    HStack(alignment: .center) {
                        Spacer()
                        Image(systemName: "bell.badge")
                            .foregroundColor(Color("cutepurple"))
                        Text("äģå¤Š:   \(LunarCore.solarToLunar(yearfresh(), monthfresh(), monthdayfresh())["term"]!)" as String)
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
            .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
        }
    }
}


class ComplicationController: NSObject, CLKComplicationDataSource {
    func getComplicationDescriptors(handler: @escaping ([CLKComplicationDescriptor]) -> Void) {
        let families: [CLKComplicationFamily] = [.circularSmall, .modularLarge, .graphicBezel, .graphicCircular, .graphicCorner, .modularSmall, .graphicRectangular, .utilitarianSmall, .utilitarianSmallFlat, .utilitarianLarge]
        //CLKComplicationFamily.allCases
        let descriptors = [
            CLKComplicationDescriptor(identifier: "complication", displayName: "æļé¸ÂˇTimebird", supportedFamilies: families)
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
        case .circularSmall://åˇ˛æ ĄéĒ
            let image = CLKImageProvider(onePieceImage: UIImage(named: "icon")!)
            let template = CLKComplicationTemplateCircularSmallRingImage(imageProvider: image, fillFraction: 1.0, ringStyle: CLKComplicationRingStyle.closed)
            entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler (entry)
        case .modularSmall://åˇ˛æ ĄéĒ
            let image = CLKImageProvider(onePieceImage: UIImage(named: "icon")!)
            image.tintColor = UIColor(Color("cuteyellow2"))
            let template = CLKComplicationTemplateModularSmallRingImage(imageProvider: image, fillFraction: 1.0, ringStyle: CLKComplicationRingStyle.closed)
            template.tintColor = UIColor(Color.green)
            entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler (entry)
        case .modularLarge://åˇ˛æ ĄéĒ
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
        case .utilitarianSmall://
            let image = CLKImageProvider(onePieceImage: UIImage(named: "Complication/Utilitarian")!)
            let template = CLKComplicationTemplateUtilitarianSmallRingImage(imageProvider: image, fillFraction: 1.0, ringStyle: CLKComplicationRingStyle.closed)
            entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler (entry)
        case .utilitarianSmallFlat://åˇ˛æ ĄéĒ
            let text = CLKSimpleTextProvider(text: "æļé¸ÂˇTimebird")
            let template = CLKComplicationTemplateUtilitarianSmallFlat(textProvider: text)
            entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler (entry)
        case .utilitarianLarge://åˇ˛æ ĄéĒ
            let text = CLKSimpleTextProvider(text: "æļé¸ÂˇTimebird")
            let template = CLKComplicationTemplateUtilitarianLargeFlat(textProvider: text)
            entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler (entry)
        case .graphicCorner://
            let image = CLKFullColorImageProvider(fullColorImage: UIImage(named: "Complication/Graphic Corner")!)
            let template = CLKComplicationTemplateGraphicCornerCircularImage(imageProvider: image)
            entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler (entry)
        case .graphicCircular://
            let image = CLKFullColorImageProvider(fullColorImage: UIImage(named: "Complication/Graphic Circular")!)
            let template = CLKComplicationTemplateGraphicCircularImage(imageProvider: image)
            entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler (entry)
        case .graphicBezel://
            let image = CLKFullColorImageProvider(fullColorImage: UIImage(named: "Complication/Graphic Bezel")!)
            let circulartemplate = CLKComplicationTemplateGraphicCircularImage(imageProvider: image)
            let text = CLKSimpleTextProvider(text: "æļé¸ÂˇTimebird")
            let template = CLKComplicationTemplateGraphicBezelCircularText(circularTemplate: circulartemplate, textProvider: text)
            entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler (entry)
        case .graphicRectangular://åˇ˛æ ĄéĒ
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
        case .modularSmall:
            let image = CLKImageProvider(onePieceImage: UIImage(named: "icon")!)
            image.tintColor = UIColor(Color("cuteyellow2"))
            let template = CLKComplicationTemplateModularSmallRingImage(imageProvider: image, fillFraction: 1.0, ringStyle: CLKComplicationRingStyle.closed)
            template.tintColor = UIColor(Color.green)
            handler (template)
        case .modularLarge:
            let right1 = CLKSimpleTextProvider(text: " åŖŦæđŽ")
            let right2 = CLKSimpleTextProvider(text: " ä¸æđ")
            let right3 = CLKSimpleTextProvider(text: " äēĨæļđˇ")
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
            let image = CLKImageProvider(onePieceImage: UIImage(named: "Complication/Utilitarian")!)
            let template = CLKComplicationTemplateUtilitarianSmallRingImage(imageProvider: image, fillFraction: 1.0, ringStyle: CLKComplicationRingStyle.closed)
            handler (template)
        case .utilitarianSmallFlat:
            let text = CLKSimpleTextProvider(text: "æļé¸ÂˇTimebird")
            let template = CLKComplicationTemplateUtilitarianSmallFlat(textProvider: text)
            handler (template)
        case .utilitarianLarge:
            let text = CLKSimpleTextProvider(text: "æļé¸ÂˇTimebird")
            let template = CLKComplicationTemplateUtilitarianLargeFlat(textProvider: text)
            handler (template)
        case .graphicCorner:
            let image = CLKFullColorImageProvider(fullColorImage: UIImage(named: "Complication/Graphic Corner")!)
            let template = CLKComplicationTemplateGraphicCornerCircularImage(imageProvider: image)
            handler (template)
        case .graphicCircular:
            let image = CLKFullColorImageProvider(fullColorImage: UIImage(named: "Complication/Graphic Circular")!)
            let template = CLKComplicationTemplateGraphicCircularImage(imageProvider: image)
            handler (template)
        case .graphicBezel:
            let image = CLKFullColorImageProvider(fullColorImage: UIImage(named: "Complication/Graphic Bezel")!)
            let circulartemplate = CLKComplicationTemplateGraphicCircularImage(imageProvider: image)
            let text = CLKSimpleTextProvider(text: "æļé¸ÂˇTimebird")
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
