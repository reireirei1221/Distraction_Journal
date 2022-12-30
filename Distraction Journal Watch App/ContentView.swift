//
//  ContentView.swift
//  Distraction Journal Watch App
//
//  Created by 澤野令 on 2022/12/26.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    
    @State private var isShowingLogDistractionView: Bool = false
    @State private var isShowingRemindMeView: Bool = false
    @ObservedObject var notificationModel: NotificationModel = NotificationModel()

    init() {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: .alert) { granted, error in
                if granted {
                    print("許可されました！")
//                    notificationModel.sendNotificationRequest()
                }else{
                    print("拒否されました...")
                }
            }
        }
    
    var body: some View {
        VStack {
            Text("Let's Stay Focused Today!")
                .multilineTextAlignment(.center)
            Divider().background(Color.orange)
            Spacer()
            Button("Log Distraction") {
                isShowingLogDistractionView.toggle()
            }
            .sheet(isPresented: $isShowingLogDistractionView) {
                LogDistractionView()
            }
            Spacer()
            Button("Remind Me") {
                isShowingRemindMeView.toggle()
            }
            .sheet(isPresented: $isShowingRemindMeView) {
                RemindMeView()
            }
            Button("Notification") {
                notificationModel.sendNotificationRequest()
            }
        
        }
        .padding()
    }
}

struct LogDistractionView: View {
    struct Ocean: Identifiable {
        let name: String
        let id = UUID()
    }

    private var oceans = [
        Ocean(name: "Youtube"),
        Ocean(name: "Twitter"),
        Ocean(name: "Instagram"),
        Ocean(name: "Music"),
        Ocean(name: "Food")
    ]
    
    var body: some View {
        VStack {
            
//            Button("Youtube") {
//            }
//            Spacer()
//            Button("Twitter") {
//            }
//            Spacer()
//            Button("Day Dreaming") {
//            }
//            .padding()
            
            List(oceans) {
                Text($0.name)
            }
        }
    }
}

struct RemindMeView: View {
    
    enum Flavor: String, CaseIterable, Identifiable {
        case chocolate, vanilla, strawberry
        var id: Self { self }
    }

    @State private var selectedFlavor: Flavor = .chocolate
    
    var body: some View {
        VStack {
            Text("Check on me for the next:")
            Picker("", selection: $selectedFlavor) {
                ForEach(Flavor.allCases) { flavor in
                    Text(flavor.rawValue.capitalized)
                }
            }
            .frame(width: 120, height: 100)
            Button("Start") {
            }
            Spacer()
            Button("Delete") {
            }
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
