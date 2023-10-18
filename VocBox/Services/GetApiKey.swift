//
//  GetApiKey.swift
//  VocBox
//
//  Created by Jessie Pastan on 10/14/23.
//

import Foundation

class FetchApiKey {
    
   static func fetchWordNikApiKey () -> String {
      
        if let secretFileURL = Bundle.main.url(forResource: "WNApiKey", withExtension: "json") {
            do {
                let decoder = JSONDecoder()
                let secretData = try Data(contentsOf: secretFileURL)
                if let key = try decoder.decode(ApiKey?.self, from: secretData) {
                    //print(key.apikey ?? "can't get key")
                    return key.apikey ?? ""
                } else {
                    print("Error: Unable to decode secret data")
                }
            } catch {
                print("Error reading secret: \(error)")
            }
        } else {
            print("Secret file not found")
        }
        return ""
    }
    
}
