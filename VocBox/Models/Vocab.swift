//
//  Vocab.swift
//  VocBox
//
//  Created by Jessie Pastan on 9/25/23.
//

import Foundation
struct Vocabulary : Codable {
    var word: String?
    var phonetic: String?
}
 
struct Phonetic : Codable {
    var text: String
    var audio: String?
    
}


extension Phonetic {
    static var MOCKPhonetic: [Phonetic] {
        [.init(text: "həˈləʊ", audio:  "//ssl.gstatic.com/dictionary/static/sounds/20200429/hello--_gb_1.mp3")]
        
    }
}
extension  Vocabulary {
    static var MOCKVocab: Vocabulary {
        .init(word: "MockingWord", phonetic: "MockPhonetic")
        
    }
}

