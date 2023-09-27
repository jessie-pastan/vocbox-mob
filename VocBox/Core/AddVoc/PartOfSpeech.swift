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
}

extension PartOfSpeechType  {
    static let types: [PartOfSpeechType] = [
        .init(id: 1, title: "Noun", acronym: "n."),
        .init(id: 2, title: "Verb",acronym: "v."),
        .init(id: 3, title: "Adverb", acronym: "adv."),
        .init(id: 4, title: "Adjective", acronym: "adj."),
        .init(id: 5, title: "Preposition", acronym: "prep."),
        .init(id: 6, title: "Conjunction", acronym: "conj."),
       
    ]
}
