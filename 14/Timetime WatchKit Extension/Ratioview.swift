//
//  Ratioview.swift
//  Timetime WatchKit Extension
//
//  Created by 杨恒一 on 2021/3/6.
//

import Foundation
import SwiftUI

struct ProgressBar: View {
    var progress: Float
    var whichratio: String
    var whichcolor1: Color
    var whichcolor2: Color
    var body: some View {
        VStack{
        ZStack {
            Circle()
                .stroke(lineWidth: 7.0)
                .opacity(0.2)
                .foregroundColor(whichcolor1)
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress/100, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 4.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(whichcolor2)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)
                //.bold()
            Text("\(whichratio)")
                .font(.footnote)
        }
            let ratiopart = String(progress).components(separatedBy: ".")
            let fistratio = ratiopart[0]
           // let lastratio = String(format: "%2f", ratiopart[1])
            let lastratio = ratiopart[1]

            Text("\(fistratio)")
                .font(.footnote)
            Text(".\(lastratio[0..<3])%")
                .font(.system(size:10.5))
        }
    }
}
