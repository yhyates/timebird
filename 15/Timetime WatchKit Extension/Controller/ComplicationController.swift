//
//  ComplicationController.swift
//  Timetime WatchKit Extension
//
//  Created by 杨恒一 on 2021/1/29.
//

import ClockKit
import SwiftUI

struct clockk: View {
    var today = Date()
    var body: some View {
        Text("\(today)")
            .font(.footnote)
            .multilineTextAlignment(.center)
    }
}


class ComplicationController: NSObject, CLKComplicationDataSource {
    func getComplicationDescriptors(handler: @escaping ([CLKComplicationDescriptor]) -> Void) {
        let descriptors = [
            CLKComplicationDescriptor(identifier: "complication", displayName: "Timetime", supportedFamilies: CLKComplicationFamily.allCases)
        ]
        handler(descriptors)
    }
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        //handler([.forward, .backward])
        handler([.forward])
        //handler([])
    }
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        // Indicate that the app can provide timeline entries for the next 24 hours.
        handler(Date().addingTimeInterval(24.0 * 60.0 * 60.0))
    }
    
    //    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
    //            handler(Date())
    //    }
    //
    //    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
    //        var countcycle = ["1", "3", "5", "10", "15", "20", "25", "30", "45", "60", "90"]
    //        let stringcycle = UserDefaults.standard.string(forKey: "cycle")
    //        let intcycle2 = Int(String(stringcycle!))
    //        let cycleselceted = Int(String(countcycle[intcycle2!-1]))
    //        let intcycle = cycleselceted!//int型cycle
    //            handler(Date().addingTimeInterval(TimeInterval(intcycle * 60)))
    //    }
    
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
        let appNameTextProvider = CLKSimpleTextProvider(text: "🍍計時器")
        let relativeDateTextProvider = CLKRelativeDateTextProvider(date: Date().addingTimeInterval(25.0*60.0), style: .offsetShort, units: [.minute])
        let longRelativeDateTextProvider = CLKRelativeDateTextProvider(date: Date().addingTimeInterval(25.0*60.0), style: .naturalFull, units: [.minute, .second])
        let simpleTextProvider = CLKSimpleTextProvider(text: "🍍")
        let gaugeProvider = CLKTimeIntervalGaugeProvider(style: .fill, gaugeColors: [.green, .yellow, .orange], gaugeColorLocations: [0, 0.2, 0.8], start: Date(), end: Date().addingTimeInterval(25.0*60.0))
        let tintColor = UIColor.yellow
        
        
        switch complication.family {
        case .modularSmall:
            let template = CLKComplicationTemplateModularSmallStackText()
            template.line1TextProvider = CLKSimpleTextProvider(text: "PM10")
            template.line2TextProvider = CLKSimpleTextProvider(text: "75")
            entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler (entry)
        case .modularLarge:
            let template = CLKComplicationTemplateModularLargeStandardBody()
            template.headerTextProvider = CLKSimpleTextProvider(text: "复杂功能-传值测试")
            template.body1TextProvider = CLKSimpleTextProvider(text: "TimeTime")
            template.body2TextProvider = CLKSimpleTextProvider(text: "99999)")
            entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler (entry)
        case .circularSmall:
            let template = CLKComplicationTemplateCircularSmallStackText()
            template.line1TextProvider = CLKSimpleTextProvider(text: "PM")
            template.line2TextProvider = CLKSimpleTextProvider(text: "75")
            entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler (entry)
        case .graphicRectangular:
            let template = CLKComplicationTemplateGraphicRectangularFullView(clockk())
            entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler (entry)
            
        //            //确定模版
        //            let template = CLKComplicationTemplateGraphicRectangularTextGauge()
        //            //模版头部标题
        //            template.headerTextProvider = CLKSimpleTextProvider(text: "🍅Timetime")
        //            //模版主题内容
        //            var countcycle = ["1", "3", "5", "10", "15", "20", "25", "30", "45", "60", "90"]
        //            let stringcycle = UserDefaults.standard.string(forKey: "cycle")
        //            let intcycle2 = Int(String(stringcycle!))
        //            let cycleselceted =  Int(String(countcycle[intcycle2!-1]))
        //            let intcycle = cycleselceted!//int型cycle
        //            if Date() > Date().addingTimeInterval(TimeInterval(intcycle * 60)) {
        //                template.body1TextProvider = CLKRelativeDateTextProvider(date: Date().addingTimeInterval(TimeInterval(intcycle * 60)), style: .naturalAbbreviated, units: [.year, .minute, .second])//.minute, .second
        //                //naturalAbbreviated natural  naturalFull  timer
        //                let tintColor = UIColor.yellow
        //                template.gaugeProvider = CLKTimeIntervalGaugeProvider(style: .fill, gaugeColors: [.green, .yellow, .orange], gaugeColorLocations: [0, 0.5, 0.8], start: Date(), end: Date().addingTimeInterval(TimeInterval(intcycle * 60)))
        //                entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
        //                handler (entry)
        //            } else {
        //                let tintColor = UIColor.yellow
        //                template.gaugeProvider = CLKTimeIntervalGaugeProvider(style: .fill, gaugeColors: [.green, .yellow, .orange], gaugeColorLocations: [0, 0.5, 0.8], start: Date(), end: Date().addingTimeInterval(TimeInterval(60)))
        //                entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
        //                handler (entry)
        //            }
       
        default:
            handler (nil)
        }
        
    }
    func getLocalizableSampleTemplate(
        for complication: CLKComplication,
        withHandler handler: @escaping (CLKComplicationTemplate?) -> Void)
    {
        switch complication.family {
        case .modularSmall:
            let template = CLKComplicationTemplateModularSmallStackText()
            template.line1TextProvider = CLKSimpleTextProvider(text: "PM10")
            template.line2TextProvider = CLKSimpleTextProvider(text: "50")
            handler (template)
        case .modularLarge:
            let template = CLKComplicationTemplateModularLargeStandardBody()
            template.headerTextProvider = CLKSimpleTextProvider(text: "复杂功能")
            template.body1TextProvider = CLKSimpleTextProvider(text: "TimeTime")
            template.body2TextProvider = CLKSimpleTextProvider(text: "50")
            handler (template)
            
        case .circularSmall:
            let template = CLKComplicationTemplateCircularSmallStackText()
            template.line1TextProvider = CLKSimpleTextProvider(text: "PM")
            template.line2TextProvider = CLKSimpleTextProvider(text: "50")
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
