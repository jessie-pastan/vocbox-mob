//
//  TrimString.swift
//  VocBox
//
//  Created by Jessie P on 9/21/23.
//

import Foundation

class TrimString {
    //MARK: remove "" and white spaces before and after word
    static func trimString(input: String) -> String {
        let removedQuotes = input.replacingOccurrences(of: "\"", with: "")
        let trimmedString = removedQuotes.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedString
    }
}
