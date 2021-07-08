//
//  CustomTimer.swift
//  ADCBGamification
//
//  Created by SKY on 08/07/21.
//

import Foundation
class CustomTimer {
    static var shared = CustomTimer()
    private init() {}
    private var timer: Timer?
    var handle: (()->Void)?
    
    func startTimer(complition:(()->Void)? = nil) {
        self.handle = complition
        DispatchQueue.main.async {
            self.stopTimer()
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
        }
    }
    
     @objc private func updateTime() {
        self.handle?()
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

