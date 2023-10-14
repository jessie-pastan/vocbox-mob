//
//  Pronunciation.swift
//  VocBox
//
//  Created by Jessie Pastan on 9/25/23.
//

import Foundation
class SplitPronunciation {
    // split result of pronunciation that get back from API call into an array
    // and extract only first one of the pronunciation
    
    static func getFirstPronunciation(text: String) -> String {
        //verify wether we got back more than 1 pronunciation
        if text.contains(",") {
            let words = text.components(separatedBy: ",")
                   if let firstWord = words.first {
                       return firstWord.trimmingCharacters(in: .whitespaces)
                   } else {
                       return "No words found"
                   }
        }else {
            return text
        }
    }
    
}
