//
//  RecallVocViewModel.swift
//  VocBox
//
//  Created by Jessie P on 9/20/23.
//

import Foundation
import CoreData

class RecallVocViewModel: ObservableObject {
     
    
      
   
    @Published var percentage = ""
    @Published var vocabRecall: Int64 = 0
    @Published var vocab = ""
    
    
    func vocabExistInCoreData(text: String, vocabs: [Vocab]) -> Bool {
        for item in vocabs {
            if text == item.viewVocab {
                //add score to vocab that got recalled
                self.vocabRecall = item.recall + 1
                
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
    
}
