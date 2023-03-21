//
//  WatchConnect.swift
//  Distraction Journal Watch App
//
//  Created by 澤野令 on 2022/12/29.
//

import Foundation
import WatchConnectivity

class ExtensionDelegate: NSObject, ObservableObject, WCSessionDelegate {
    
    @Published var label: String
//    var session: WCSession
//
//    init(session: WCSession  = .default) {
//        self.session = session
//        super.init()
//        self.session.delegate = self
//        self.session.activate()
//    }
    
    override init() {
            self.label = "Hello"
            super.init()
            
            if WCSession.isSupported() {
                WCSession.default.delegate = self
                WCSession.default.activate()
            }
            // WCSession.default.transferUserInfo(["hey":"Hello"])
        }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            // Error handring if need
            print(error.localizedDescription)
        } else {
            print("Ready to talk with IOS")
            // self.session.transferUserInfo(["hey":"Hello"])
//            WCSession.default.transferUserInfo(["hey":"Hello"])
//            print("Message sent")
//            print(WCSession.default.isReachable)
        }
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        print("This is the user info! \(userInfo)")
        self.label = "Received!"
    }
}


