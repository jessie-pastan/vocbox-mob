//
//  PartOfSpeech.swift
//  VocBox
//
//  Created by Jessie P on 9/16/23.
//

import Foundation


struct PartOfSpeechType: Identifiable, Equatable{
    var id: Int
    var title: String
    var acronym: String
    var type: String
}

extension PartOfSpeechType  {
    static let types: [PartOfSpeechType] = [
        .init(id: 1, title: "Noun", acronym: "n.", type: "noun"),
        .init(id: 2, title: "Verb",acronym: "v.", type: "verb"),
        .init(id: 3, title: "Adverb", acronym: "adv.", type: "adverb"),
        .init(id: 4, title: "Adjective", acronym: "adj.", type: "adjective"),
        .init(id: 5, title: "Preposition", acronym: "prep.", type: "preposition"),
        .init(id: 6, title: "Conjunction", acronym: "conj.", type: "conjuction" ),
       
    ]
}
