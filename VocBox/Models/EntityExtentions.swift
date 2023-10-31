//
//  EntityExtentions.swift
//  VocBox
//
//  Created by Jessie P on 9/14/23.
//

import Foundation
import CoreData
       
extension Vocab {
    var viewVocab: String {
        vocab ?? "Vocabulary"
    }
    var viewDefinition: String {
        definition ?? "Definition"
    }
    var viewPhonetic: String {
        phonetic ?? "/fəˈnedik/"
    }
    var viewType: String {
        type ?? "Part Of Speech"
    }
    
    var viewFavourite: Bool {
        favourite
    }
    
    var viewCreateDate: String {
        let today = Date()
        return createDate?.formatted(date: .abbreviated, time: .shortened) ?? today.formatted(date: .abbreviated, time: .shortened)
    }
    
    var viewRecall: Int {
        Int(recall)
    }
    
    
}

extension Score {
    var viewDate: String {
        let today = Date()
        return date?.formatted(date: .abbreviated, time: .shortened) ?? today.formatted(date: .abbreviated, time: .shortened)
        
    }
    
}

extension User {
    var viewJoinedDate: String {
        let today = Date()
        return joinedDate?.formatted(date: .abbreviated, time: .omitted) ?? today.formatted(date: .abbreviated, time: .omitted)
    }
    
    var viewReminderTime: Date {
        return reminderTime ?? Date()
    }
}
