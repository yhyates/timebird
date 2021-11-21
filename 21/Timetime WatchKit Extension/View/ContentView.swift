//
//  TimetimeApp.swift
//  Timetime WatchKit Extension
//
//  Created by 杨恒一 on 2021/1/29.
//

import SwiftUI
import Foundation
import UserNotifications

struct ContentView: View {
    @State var selectedPage = 0
    @State var isPresented = false
    @State var isPresentedtwo = false
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: Time.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Time.userOrder, ascending: true),
            NSSortDescriptor(keyPath: \Time.who, ascending: true)
        ]
    ) var times: FetchedResults<Time>
    @FetchRequest(
        entity: Recorder.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Recorder.who, ascending: true)
        ]
    ) var recorders: FetchedResults<Recorder>
    var body: some View {

       // TabView{
        
            TabView(selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Selection@*/.constant(1)/*@END_MENU_TOKEN@*/) {
           //第一页
            home()
            //第二页
            todoView()
            //第三页
            VStack{
                Button(action: { self.isPresented.toggle() }) {
                    Spacer()
                    Text("Pure Days")
                    Spacer()
                    Spacer()
                    Image(systemName: "plus")
                    Spacer()
                }
                .frame(height: 30.0)
                .foregroundColor(Color.black)
                //.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("cutegreen2")/*@END_MENU_TOKEN@*/)
                .cornerRadius(20.0)
                .background(LinearGradient(gradient: Gradient(colors: [Color("cuteblue2"), Color("cuteyellow2")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                .cornerRadius(20.0)

                List {
                    ForEach(times, id: \.who) {
                        TimeRow(movie: $0)
                    }
                    .onDelete(perform: deleteMovie)
                    .onMove(perform: movemove)
                }
                .listStyle(CarouselListStyle())
                .sheet(isPresented: $isPresented) {
                    AddTime { who, icon, release in
                        self.addTime(who: who, icon: icon, releaseDate: release)
                        self.isPresented = false
                    }
                }
            }
            .navigationTitle("📅记录时间点")
            .navBarTitleDisplayMode(.inline)
            
            //第四页
            VStack{
                Button(action: { self.isPresentedtwo.toggle() }) {
                    Spacer()
                    Text("Behaviors")
                    Spacer()
                    Spacer()
                    Image(systemName: "plus")
                    Spacer()
                }
                .frame(height: 30.0)
                .foregroundColor(Color.black)
                //.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("cutegreen2")/*@END_MENU_TOKEN@*/)
                .cornerRadius(20.0)
                .background(LinearGradient(gradient: Gradient(colors: [Color("cutepurple"), Color("cutered2")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                .cornerRadius(20.0)
                List {
                    ForEach(recorders, id: \.who) {
                        RecordRow(recorders: $0)
                    }
                    .onDelete(perform: deleteRecord)
                }
                .listStyle(CarouselListStyle())
                .sheet(isPresented: $isPresentedtwo) {
                    AddRecord { who, icon, release in
                        self.addRecord(who: who, icon: icon, releaseDate: release)
                        self.isPresentedtwo = false
                    }
                }
            }
            .navigationTitle("👀行为习惯")
            .navBarTitleDisplayMode(.inline)

        }//tabview
        .onAppear{get_data()
            requestNotificationPermissions()
        }

    }//view
    func deleteMovie(at offsets: IndexSet) {
        offsets.forEach { index in
            let movie = self.times[index]
            self.managedObjectContext.delete(movie)
            let who = self.times[index].who
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["\(String(describing: who!))0"])
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["\(String(describing: who!))1"])
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["\(String(describing: who!))3"])
    //            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["\(String(describing: who!))7"])
        }
        saveContext()
    }
    func movemove(from source: IndexSet, to destination: Int)
    {
        var revisedItems: [Time] = times.map{ $0 }
        revisedItems.move(fromOffsets: source, toOffset: destination )
        for reverseIndex in stride( from: revisedItems.count - 1,
                                    through: 0,
                                    by: -1 )
        {
            revisedItems[ reverseIndex ].userOrder =
                Int16( reverseIndex )
        }
        saveContext()
    }
    func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("保存出错: \(error)")
        }
    }
    func deleteRecord(at offsets: IndexSet) {
        offsets.forEach { index in
            let rrecord = self.recorders[index]
            self.managedObjectContext.delete(rrecord)
            let who = self.recorders[index].who
            //UserDefaults.standard.set([], forKey: "Record-\(who!)")
            UserDefaults.standard.removeObject(forKey: "Record-\(who!)")
        }
        saveContext()
    }
    func addRecord(who: String, icon: String, releaseDate: Date) {
        let newMovie = Recorder(context: managedObjectContext)
        newMovie.who = who
        newMovie.icon = icon
        newMovie.releaseDate = releaseDate
        saveContext()
    }
    func addTime(who: String, icon: String, releaseDate: Date) {
        let newMovie = Time(context: managedObjectContext)
        newMovie.who = who
        newMovie.icon = icon
        newMovie.releaseDate = releaseDate
        saveContext()
    }
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()

    }
}
