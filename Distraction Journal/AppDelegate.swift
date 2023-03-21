//
//  AppDelegate.swift
//  Distraction Journal
//
//  Created by 澤野令 on 2023/03/17.
//

import Foundation
import WatchConnectivity

class AppDelegate: NSObject, ObservableObject, WCSessionDelegate {
    
//    var session: WCSession
    @Published var label: String
    
//    init(session: WCSession  = .default) {
//        self.session = session
//        self.label = "AAAA"
//        super.init()
//        self.session.delegate = self
//        self.session.activate()
//        // self.session.transferUserInfo(["hey":"Hello"])
//    }
    
    override init() {
        self.label = "Hello"
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
        // WCSession.default.transferUserInfo(["hey":"Hello"])
        // print("Message sent")
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            // Error handring if need
            print(error.localizedDescription)
        } else {
            print("Ready to talk with Apple Watch")
//            WCSession.default.transferUserInfo(["hey":"Hello"])
//            print(WCSession.default.isReachable)
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("Inactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("Deactivated")
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        print("This is the user info! \(userInfo)")
        self.label = "UserInfo Received"
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("This is the user info! \(message)")
        self.label = "Message Received"
    }
    
    func makeFilePath() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd_HHmmss"
        let filename = formatter.string(from: Date()) + ".csv"
        let fileUrl = url.appendingPathComponent(filename)
        print(fileUrl.absoluteURL)
        return fileUrl
    }
    
    func session(_ session: WCSession, didReceive file: WCSessionFile){
        print("File received!")
        // self.label = "\(file.fileURL)"
        do {
            try FileManager.default.copyItem(at: file.fileURL, to: self.makeFilePath())
        } catch {
            print("移動失敗")
        }
    }

}
