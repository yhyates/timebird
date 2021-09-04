//
//  NotificationView.swift
//  Timetime WatchKit Extension
//
//  Created by 杨恒一 on 2021/1/29.
//


import SwiftUI

struct NotificationView: View {
    var body: some View {
        Text("Hello, World!")
      
        Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
            HStack {
                Label("本周：", systemImage: "w.circle")
                Text("%")
                    .multilineTextAlignment(.trailing)
                    .frame(width: 60)
            }
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color("cutegray"), Color("cutepurple")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
        .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
        

        //分割线
        Divider()
            .padding()
        Text("\(Date())")
            .font(.footnote)
            .multilineTextAlignment(.center)
        
        
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
