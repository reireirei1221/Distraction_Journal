//
//  WatchConnect.swift
//  Distraction Journal Watch App
//
//  Created by 澤野令 on 2022/12/29.
//

import Foundation
import WatchConnectivity

class ExtensionDelegate: NSObject {
    
    private let session: WCSession
    
    init(session: WCSession  = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }

}

extension ExtensionDelegate: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            // Error handring if need
            print(error.localizedDescription)
        } else {
            print("The session has completed activation.")
        }
    }
}
