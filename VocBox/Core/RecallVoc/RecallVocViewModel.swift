//
//  RecallVocViewModel.swift
//  VocBox
//
//  Created by Jessie P on 9/20/23.
//

import Foundation
import CoreData
import SwiftUI

class RecallVocViewModel: ObservableObject {
     
    
      
   
    @Published var percentage = ""
    @Published var vocabRecall: Int = 0
    @Published var vocab = ""
    
    var DefinitionHints = [String]()
    
    
    func vocabExistInCoreData(text: String, vocabs: [Vocab]) -> Bool {
        for item in vocabs {
            if text == item.viewVocab {
                return true
            }
        }
        return false
    }
    
    func calculateProgressPercent(vocabs: [Vocab]) -> CGFloat {
        let amount = CGFloat(vocabs.count)
        let increase = (CGFloat(1) / amount) * CGFloat(100)
        return increase
    }
    
    
    func userScorePercentage(vocabs: [Vocab], userScore: Int ) -> String {
        let userScore = Double(userScore)
        let allVocab = Double(vocabs.count)
        let percentage = (userScore / allVocab) * Double(100)
        self.percentage = String(format: "%.0f", percentage)
        return self.percentage
    }
    
    func randomHint(vocabs: FetchedResults<Vocab>) -> String {
        for vocab in vocabs {
            DefinitionHints.append(vocab.viewDefinition)
        }
        let hint = DefinitionHints.randomElement() ?? "Please add a word definition"
        
        if hint.isEmpty {
            return "Please add a word definition, then we can give you a hint!"
        }
        return hint
    }
    
}
