//
//  StoreManager.swift
//  ADCBGamification
//
//  Created by SKY on 07/07/21.
//

import Foundation

class StoreManager {
    static let shared = StoreManager()
    
    @objc var gameUrl: String {
        get {
            return UserDefaults.standard.value(forKey: "gameUrl") as? String ?? ""
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: "gameUrl")
            UserDefaults.standard.synchronize()
        }
    }
    
    @objc var accessToken: String {
        get {
            return UserDefaults.standard.value(forKey: "accessToken") as? String ?? ""
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: "accessToken")
            UserDefaults.standard.synchronize()
        }
    }
    
    @objc var msisdn: String {
        get {
            return UserDefaults.standard.value(forKey: "msisdn") as? String ?? ""
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: "msisdn")
            UserDefaults.standard.synchronize()
        }
    }
    
    @objc var language: String {
        get {
            return UserDefaults.standard.value(forKey: "language") as? String ?? ""
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: "language")
            UserDefaults.standard.synchronize()
        }
    }
}
