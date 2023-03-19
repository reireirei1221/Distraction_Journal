//
//  MotionSensor.swift
//  Distraction Journal Watch App
//
//  Created by 澤野令 on 2023/03/19.
//  参考にした記事 : https://yukblog.net/core-motion-basics/
//  https://zenn.dev/yorifuji/articles/af1b54285c1c4f7a3249

import WatchKit
import Foundation
import CoreMotion

class MotionSensor: NSObject, ObservableObject {
    
    @Published var isStarted = false
        
    @Published var xStr = "0.0"
    @Published var yStr = "0.0"
    @Published var zStr = "0.0"
    
    var file: FileHandle?
    var filePath: URL?
    var sample: Int = 0
    
    let motionManager = CMMotionManager()
    
    func open(_ filePath: URL) {
        do {
            FileManager.default.createFile(atPath: filePath.path, contents: nil, attributes: nil)
            let file = try FileHandle(forWritingTo: filePath)
            var header = ""
            header += "acceleration_x,"
            header += "acceleration_y,"
            header += "acceleration_z,"
            file.write(header.data(using: .utf8)!)
            self.file = file
            self.filePath = filePath
        } catch let error {
            print(error)
        }
    }
    
    func write(_ motion: CMDeviceMotion) {
        guard let file = self.file else { return }
        var text = ""
        text += "\(motion.userAcceleration.x),"
        text += "\(motion.userAcceleration.y),"
        text += "\(motion.userAcceleration.z),"
        text += "\n"
        file.write(text.data(using: .utf8)!)
        sample += 1
    }
    
    func close() {
        guard let file = self.file else { return }
        file.closeFile()
        print("\(sample) sample")
        self.file = nil
    }
    
    func getDocumentPath() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
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
    
    func start() {
        //if motionManager.isDeviceMotionAvailable {
        print(motionManager.isAccelerometerAvailable)
        print(motionManager.isGyroAvailable)
        print(motionManager.isMagnetometerAvailable)
        
        guard motionManager.isDeviceMotionAvailable else { return }
//        guard motionManager.isAccelerometerAvailable else { return }
        motionManager.deviceMotionUpdateInterval = 0.1
        motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {(motion:CMDeviceMotion?, error:Error?) in
            self.updateMotionData(deviceMotion: motion!)
        })
        //}
//        else {
//            print("Error : No device motion available")
//        }
        isStarted = true
        self.open(self.makeFilePath())
    }
    
    func stop() {
        isStarted =  false
        motionManager.stopDeviceMotionUpdates()
    }
    
    func updateMotionData(deviceMotion: CMDeviceMotion) {
        let xStr = String(deviceMotion.userAcceleration.x)
        let yStr = String(deviceMotion.userAcceleration.y)
        let zStr = String(deviceMotion.userAcceleration.z)
        self.write(deviceMotion)
        print("value updated")
    }
}
