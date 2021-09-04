//
//  barview.swift
//  Timetime WatchKit Extension
//
//  Created by 杨恒一 on 2021/2/18.
//
//Code from SwiftUICharts 1.5.3
//MIT License Copyright (c) 2019 Andras Samu
//

import SwiftUI
import Foundation
public struct Colors {
    public static let color1:Color = Color(hexString: "#E2FAE7")
    public static let color1Accent:Color = Color(hexString: "#72BF82")
    public static let color2:Color = Color(hexString: "#EEF1FF")
    public static let color2Accent:Color = Color(hexString: "#4266E8")
    public static let color3:Color = Color(hexString: "#FCECEA")
    public static let color3Accent:Color = Color(hexString: "#E1614C")
    public static let OrangeEnd:Color = Color(hexString: "#FF782C")
    public static let OrangeStart:Color = Color(hexString: "#EC2301")
    public static let LegendText:Color = Color(hexString: "#A7A6A8")
    public static let LegendColor:Color = Color(hexString: "#E8E7EA")
    public static let LegendDarkColor:Color = Color(hexString: "#545454")
    public static let IndicatorKnob:Color = Color(hexString: "#FF57A6")
    public static let GradientUpperBlue:Color = Color(hexString: "#C2E8FF")
    public static let GradinetUpperBlue1:Color = Color(hexString: "#A8E1FF")
    public static let GradientPurple:Color = Color(hexString: "#7B75FF")
    public static let GradientNeonBlue:Color = Color(hexString: "#6FEAFF")
    public static let GradientLowerBlue:Color = Color(hexString: "#F1F9FF")
    public static let DarkPurple:Color = Color(hexString: "#1B205E")
    public static let BorderBlue:Color = Color(hexString: "#4EBCFF")
}

public struct GradientColor {
    public let start: Color
    public let end: Color
    
    public init(start: Color, end: Color) {
        self.start = start
        self.end = end
    }
    
    public func getGradient() -> Gradient {
        return Gradient(colors: [start, end])
    }
}

public struct GradientColors {
    public static let orange = GradientColor(start: Colors.OrangeStart, end: Colors.OrangeEnd)
    public static let blue = GradientColor(start: Colors.GradientPurple, end: Colors.GradientNeonBlue)
    public static let green = GradientColor(start: Color(hexString: "0BCDF7"), end: Color(hexString: "A2FEAE"))
    public static let blu = GradientColor(start: Color(hexString: "0591FF"), end: Color(hexString: "29D9FE"))
    public static let bluPurpl = GradientColor(start: Color(hexString: "4ABBFB"), end: Color(hexString: "8C00FF"))
    public static let purple = GradientColor(start: Color(hexString: "741DF4"), end: Color(hexString: "C501B0"))
    public static let prplPink = GradientColor(start: Color(hexString: "BC05AF"), end: Color(hexString: "FF1378"))
    public static let prplNeon = GradientColor(start: Color(hexString: "FE019A"), end: Color(hexString: "FE0BF4"))
    public static let orngPink = GradientColor(start: Color(hexString: "FF8E2D"), end: Color(hexString: "FF4E7A"))
}

public struct Styles {
    public static let lineChartStyleOne = ChartStyle(
        backgroundColor: Color.white,
        accentColor: Colors.OrangeStart,
        secondGradientColor: Colors.OrangeEnd,
        textColor: Color.black,
        legendTextColor: Color.gray,
        dropShadowColor: Color.gray)
    
    public static let barChartStyleOrangeLight = ChartStyle(
        backgroundColor: Color.white,
        accentColor: Colors.OrangeStart,
        secondGradientColor: Colors.OrangeEnd,
        textColor: Color.black,
        legendTextColor: Color.gray,
        dropShadowColor: Color.gray)
    //改我
    public static let barChartStyleOrangeDark = ChartStyle(
        backgroundColor: Color.black,
        accentColor: Colors.GradientNeonBlue,
        secondGradientColor: Colors.GradientPurple,
        textColor: Color.white,
        legendTextColor: Color.gray,
        dropShadowColor: Color.gray)
    
    public static let barChartStyleNeonBlueLight = ChartStyle(
        backgroundColor: Color.white,
        accentColor: Colors.GradientNeonBlue,
        secondGradientColor: Colors.GradientPurple,
        textColor: Color.black,
        legendTextColor: Color.gray,
        dropShadowColor: Color.gray)
    
    public static let barChartStyleNeonBlueDark = ChartStyle(
        backgroundColor: Color.black,
        accentColor: Colors.GradientNeonBlue,
        secondGradientColor: Colors.GradientPurple,
        textColor: Color.white,
        legendTextColor: Color.gray,
        dropShadowColor: Color.gray)
    
    public static let barChartMidnightGreenDark = ChartStyle(
        backgroundColor: Color(hexString: "#36534D"), //3B5147, 313D34
        accentColor: Color(hexString: "#FFD603"),
        secondGradientColor: Color(hexString: "#FFCA04"),
        textColor: Color.white,
        legendTextColor: Color(hexString: "#D2E5E1"),
        dropShadowColor: Color.gray)
    
    public static let barChartMidnightGreenLight = ChartStyle(
        backgroundColor: Color.white,
        accentColor: Color(hexString: "#84A094"), //84A094 , 698378
        secondGradientColor: Color(hexString: "#50675D"),
        textColor: Color.black,
        legendTextColor:Color.gray,
        dropShadowColor: Color.gray)
    
    public static let pieChartStyleOne = ChartStyle(
        backgroundColor: Color.white,
        accentColor: Colors.OrangeEnd,
        secondGradientColor: Colors.OrangeStart,
        textColor: Color.black,
        legendTextColor: Color.gray,
        dropShadowColor: Color.gray)
    
    public static let lineViewDarkMode = ChartStyle(
        backgroundColor: Color.black,
        accentColor: Colors.OrangeStart,
        secondGradientColor: Colors.OrangeEnd,
        textColor: Color.white,
        legendTextColor: Color.white,
        dropShadowColor: Color.gray)
}

public struct ChartForm {
    #if os(watchOS)
    public static let small = CGSize(width:120, height:90)
    public static let medium = CGSize(width:120, height:160)
    public static let large = CGSize(width:10, height:90)
    public static let extraLarge = CGSize(width:180, height:90)
    public static let detail = CGSize(width:180, height:160)
    #else
    public static let small = CGSize(width:180, height:120)
    public static let medium = CGSize(width:180, height:240)
    public static let large = CGSize(width:30, height:120)
    public static let extraLarge = CGSize(width:360, height:240)
    public static let detail = CGSize(width:180, height:120)
    #endif
}

public class ChartStyle {
    public var backgroundColor: Color
    public var accentColor: Color
    public var gradientColor: GradientColor
    public var textColor: Color
    public var legendTextColor: Color
    public var dropShadowColor: Color
    public weak var darkModeStyle: ChartStyle?
    
    public init(backgroundColor: Color, accentColor: Color, secondGradientColor: Color, textColor: Color, legendTextColor: Color, dropShadowColor: Color){
        self.backgroundColor = backgroundColor
        self.accentColor = accentColor
        self.gradientColor = GradientColor(start: accentColor, end: secondGradientColor)
        self.textColor = textColor
        self.legendTextColor = legendTextColor
        self.dropShadowColor = dropShadowColor
    }
    
    public init(backgroundColor: Color, accentColor: Color, gradientColor: GradientColor, textColor: Color, legendTextColor: Color, dropShadowColor: Color){
        self.backgroundColor = backgroundColor
        self.accentColor = accentColor
        self.gradientColor = gradientColor
        self.textColor = textColor
        self.legendTextColor = legendTextColor
        self.dropShadowColor = dropShadowColor
    }
    
    public init(formSize: CGSize){
        self.backgroundColor = Color.white
        self.accentColor = Colors.OrangeStart
        self.gradientColor = GradientColors.orange
        self.legendTextColor = Color.gray
        self.textColor = Color.black
        self.dropShadowColor = Color.gray
    }
}

public class ChartData: ObservableObject, Identifiable {
    @Published var points: [(String,Double)]
    var valuesGiven: Bool = false
    var ID = UUID()
    
    public init<N: BinaryFloatingPoint>(points:[N]) {
        self.points = points.map{("", Double($0))}
    }
    public init<N: BinaryInteger>(values:[(String,N)]){
        self.points = values.map{($0.0, Double($0.1))}
        self.valuesGiven = true
    }
    public init<N: BinaryFloatingPoint>(values:[(String,N)]){
        self.points = values.map{($0.0, Double($0.1))}
        self.valuesGiven = true
    }
    public init<N: BinaryInteger>(numberValues:[(N,N)]){
        self.points = numberValues.map{(String($0.0), Double($0.1))}
        self.valuesGiven = true
    }
    public init<N: BinaryFloatingPoint & LosslessStringConvertible>(numberValues:[(N,N)]){
        self.points = numberValues.map{(String($0.0), Double($0.1))}
        self.valuesGiven = true
    }
    
    public func onlyPoints() -> [Double] {
        return self.points.map{ $0.1 }
    }
}

public class MultiLineChartData: ChartData {
    var gradient: GradientColor
    
    public init<N: BinaryFloatingPoint>(points:[N], gradient: GradientColor) {
        self.gradient = gradient
        super.init(points: points)
    }
    
    public init<N: BinaryFloatingPoint>(points:[N], color: Color) {
        self.gradient = GradientColor(start: color, end: color)
        super.init(points: points)
    }
    
    public func getGradient() -> GradientColor {
        return self.gradient
    }
}

public class TestData{
    static public var data:ChartData = ChartData(points: [37,72,51,22,39,47,66,85,50])
    static public var values:ChartData = ChartData(values: [("2017 Q3",220),
                                                            ("2017 Q4",1550),
                                                            ("2018 Q1",8180),
                                                            ("2018 Q2",18440),
                                                            ("2018 Q3",55840),
                                                            ("2018 Q4",63150), ("2019 Q1",50900), ("2019 Q2",77550), ("2019 Q3",79600), ("2019 Q4",92550)])
}

extension Color {
    init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (r, g, b) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (0, 0, 0)
        }
        self.init(red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255)
    }
}

class HapticFeedback {
    #if os(watchOS)
    //watchOS implementation
    static func playSelection() -> Void {
        WKInterfaceDevice.current().play(.click)
    }
    #else
    //iOS implementation
    let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
    static func playSelection() -> Void {
        UISelectionFeedbackGenerator().selectionChanged()
    }
    #endif
}

public struct BarChartCell : View {
    var value: Double
    var index: Int = 0
    var width: Float
    var numberOfDataPoints: Int
    var cellWidth: Double {
        return Double(width)/(Double(numberOfDataPoints) * 1.5)
    }
    var accentColor: Color
    var gradient: GradientColor?
    
    @State var scaleValue: Double = 0
    @Binding var touchLocation: CGFloat
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(LinearGradient(gradient: gradient?.getGradient() ?? GradientColor(start: accentColor, end: accentColor).getGradient(), startPoint: .bottom, endPoint: .top))
            }
            .frame(width: CGFloat(self.cellWidth))
            .scaleEffect(CGSize(width: 1, height: self.scaleValue), anchor: .bottom)
            .onAppear(){
                self.scaleValue = self.value
            }
        .animation(Animation.spring().delay(self.touchLocation < 0 ?  Double(self.index) * 0.04 : 0))
    }
}

#if DEBUG
struct ChartCell_Previews : PreviewProvider {
    static var previews: some View {
        BarChartCell(value: Double(0.75), width: 320, numberOfDataPoints: 12, accentColor: Colors.OrangeStart, gradient: nil, touchLocation: .constant(-1))
    }
}
#endif

public struct BarChartRow : View {
    var data: [Double]
    var accentColor: Color
    var gradient: GradientColor?
    
    var maxValue: Double {
        guard let max = data.max() else {
            return 1
        }
        return max != 0 ? max : 1
    }
    @Binding var touchLocation: CGFloat
    public var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .bottom, spacing: (geometry.frame(in: .local).width-22)/CGFloat(self.data.count * 3)){
                ForEach(0..<self.data.count, id: \.self) { i in
                    BarChartCell(value: self.normalizedValue(index: i),
                                 index: i,
                                 width: Float(geometry.frame(in: .local).width - 22),
                                 numberOfDataPoints: self.data.count,
                                 accentColor: self.accentColor,
                                 gradient: self.gradient,
                                 touchLocation: self.$touchLocation)
                        .scaleEffect(self.touchLocation > CGFloat(i)/CGFloat(self.data.count) && self.touchLocation < CGFloat(i+1)/CGFloat(self.data.count) ? CGSize(width: 1.4, height: 1.1) : CGSize(width: 1, height: 1), anchor: .bottom)
                        .animation(.spring())
                    
                }
            }
            .padding(.horizontal, 10)

        }
    }
    
    func normalizedValue(index: Int) -> Double {
        return Double(self.data[index])/Double(self.maxValue)
    }
}

#if DEBUG
struct ChartRow_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            BarChartRow(data: [0], accentColor: Colors.OrangeStart, touchLocation: .constant(-1))
            BarChartRow(data: [8,23,54,32,12,37,7], accentColor: Colors.OrangeStart, touchLocation: .constant(-1))
        }
    }
}
#endif

public struct BarChartView : View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    private var data: ChartData
    public var title: String
    public var legend: String?
    public var style: ChartStyle
    public var darkModeStyle: ChartStyle
    public var formSize:CGSize
    public var dropShadow: Bool
    public var cornerImage: Image
    public var valueSpecifier:String
    
    @State private var touchLocation: CGFloat = -1.0
    @State private var showValue: Bool = false
    @State private var showLabelValue: Bool = false
    @State private var currentValue: Double = 0 {
        didSet{
            if(oldValue != self.currentValue && self.showValue) {
                HapticFeedback.playSelection()
            }
        }
    }
    var isFullWidth:Bool {
        return self.formSize == ChartForm.large
    }
    public init(data:ChartData, title: String, legend: String? = nil, style: ChartStyle = Styles.barChartStyleOrangeLight, form: CGSize? = ChartForm.medium, dropShadow: Bool? = true, cornerImage:Image? = Image(systemName: "timelapse"), valueSpecifier: String? = "%.1f"){
        self.data = data
        self.title = title
        self.legend = legend
        self.style = style
        self.darkModeStyle = style.darkModeStyle != nil ? style.darkModeStyle! : Styles.barChartStyleOrangeDark
        self.formSize = form!
        self.dropShadow = dropShadow!
        self.cornerImage = cornerImage!
        self.valueSpecifier = valueSpecifier!
    }
    
    public var body: some View {
        ZStack{
          
            VStack(alignment: .leading){
                HStack{
                    if(!showValue){
                        Text(self.title)
                            .font(.footnote)
                            .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.textColor : self.style.textColor)
                    }else{
                        Text("\(self.currentValue, specifier: self.valueSpecifier)分钟")
                            .font(.footnote)
                            .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.textColor : self.style.textColor)
                    }
                    if(self.formSize == ChartForm.large && self.legend != nil && !showValue) {
                        Text(self.legend!)
                            .font(.footnote)
                            .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.accentColor : self.style.accentColor)
                            .transition(.opacity)
                            .animation(.easeOut)
                    }
                    Spacer()
                    self.cornerImage
                        .imageScale(.medium)
                        .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.legendTextColor : self.style.legendTextColor)
                }.padding()
                BarChartRow(data: data.points.map{$0.1},
                            accentColor: self.colorScheme == .dark ? self.darkModeStyle.accentColor : self.style.accentColor,
                            gradient: self.colorScheme == .dark ? self.darkModeStyle.gradientColor : self.style.gradientColor,
                            touchLocation: self.$touchLocation)
                if self.legend != nil  && self.formSize == ChartForm.medium && !self.showLabelValue{
                    Text(self.legend!)
                        .font(.headline)
                        .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.legendTextColor : self.style.legendTextColor)
                        .padding()
                }else if (self.data.valuesGiven && self.getCurrentValue() != nil) {
                    LabelView(arrowOffset: self.getArrowOffset(touchLocation: self.touchLocation),
                              title: .constant(self.getCurrentValue()!.0))
                        .offset(x: self.getLabelViewOffset(touchLocation: self.touchLocation), y: -6)
                        .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.legendTextColor : self.style.legendTextColor)
                }
                
            }
        }.frame(minWidth:self.formSize.width,
                maxWidth: self.isFullWidth ? .infinity : self.formSize.width,
                minHeight:self.formSize.height,
                maxHeight:self.formSize.height)
            .gesture(DragGesture()
                .onChanged({ value in
                    self.touchLocation = value.location.x/self.formSize.width
                    self.showValue = true
                    self.currentValue = self.getCurrentValue()?.1 ?? 0
                    if(self.data.valuesGiven && self.formSize == ChartForm.medium) {
                        self.showLabelValue = true
                    }
                })
                .onEnded({ value in
                    self.showValue = false
                    self.showLabelValue = false
                    self.touchLocation = -1
                })
        )
       
            .gesture(TapGesture()
        )
        
    }
    
    func getArrowOffset(touchLocation:CGFloat) -> Binding<CGFloat> {
        let realLoc = (self.touchLocation * self.formSize.width) - 50
        if realLoc < 10 {
            return .constant(realLoc - 10)
        }else if realLoc > self.formSize.width-110 {
            return .constant((self.formSize.width-110 - realLoc) * -1)
        } else {
            return .constant(0)
        }
    }
    
    func getLabelViewOffset(touchLocation:CGFloat) -> CGFloat {
        return min(self.formSize.width-110,max(10,(self.touchLocation * self.formSize.width) - 50))
    }
    
    func getCurrentValue() -> (String,Double)? {
        guard self.data.points.count > 0 else { return nil}
        let index = max(0,min(self.data.points.count-1,Int(floor((self.touchLocation*self.formSize.width)/(self.formSize.width/CGFloat(self.data.points.count))))))
        return self.data.points[index]
    }
}

#if DEBUG
struct ChartView_Previews : PreviewProvider {
    static var previews: some View {
        BarChartView(data: TestData.values ,
                     title: "Model 3 sales",
                     legend: "Quarterly",
                     valueSpecifier: "%.0f")
    }
}
#endif

struct LabelView: View {
    @Binding var arrowOffset: CGFloat
    @Binding var title:String
    var body: some View {
        VStack{
            ArrowUp().fill(Color.white).frame(width: 20, height: 12, alignment: .center).shadow(color: Color.gray, radius: 8, x: 0, y: 0).offset(x: getArrowOffset(offset:self.arrowOffset), y: 12)
            ZStack{
                RoundedRectangle(cornerRadius: 8).frame(width: 100, height: 32, alignment: .center).foregroundColor(Color.white).shadow(radius: 8)
                Text(self.title).font(.caption).bold()
                ArrowUp().fill(Color.white).frame(width: 20, height: 12, alignment: .center).zIndex(999).offset(x: getArrowOffset(offset:self.arrowOffset), y: -20)

            }
        }
    }
    
    func getArrowOffset(offset: CGFloat) -> CGFloat {
        return max(-36,min(36, offset))
    }
}

struct ArrowUp: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width/2, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.closeSubpath()
        return path
    }
}

struct LabelView_Previews: PreviewProvider {
    static var previews: some View {
        LabelView(arrowOffset: .constant(0), title: .constant("Tesla model 3"))
    }
}

