//
//  CrashManager.swift
//  VocBox
//
//  Created by Jessie Pastan on 11/28/23.
//

import Foundation
import FirebaseCrashlytics

final class CrashManager {
    
    static let shared = CrashManager()
    
    private init() { }
    
    func addLog(message: String) {
        Crashlytics.crashlytics().log(message)
    }
    
    
}
