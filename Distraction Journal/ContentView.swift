//
//  ContentView.swift
//  Distraction Journal
//
//  Created by 澤野令 on 2022/12/26.
//

import SwiftUI
import WatchConnectivity

struct ContentView: View {
    
    @ObservedObject var appDelegate = AppDelegate()
    @State private var isReachable = "NO"
    
    var body: some View {
        
        VStack {
//            Button(action: {
//                // iPhone と Apple Watch が疎通できるか
//                // true の場合メッセージ送信可能
//                self.isReachable = self.appDelegate.session.isReachable ? "YES": "NO"}) {
//                    Text("Check")
//                }
//                .padding(.leading, 16.0)
//            Spacer()
//            Text("isReachable")
//                .font(.headline)
//                .padding()
//            Text(self.isReachable)
//                .foregroundColor(.gray)
//                .font(.subheadline)
//                .padding()
            Text(appDelegate.label)
                        
//
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundColor(.accentColor)
//            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
