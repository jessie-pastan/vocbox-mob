//
//  RecallVocViewModel.swift
//  VocBox
//
//  Created by Jessie P on 9/20/23.
//

import Foundation
class RecallVocViewModel: ObservableObject {
    
    @Published var percentage = ""
    
    func vocabExistInCoreData(text: String, vocabs: [Vocab]) -> Bool {
        for item in vocabs {
            if text == item.viewVocab {
                //add score to vocab that got recalled
                item.recall += 1
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
    
    
    func userScorePercentage(vocabs: [Vocab], userScore: Int ) -> Double {
        let userScore = Double(userScore)
        let allVocab = Double(vocabs.count)
        let percentage = (userScore / allVocab) * Double(100)
        self.percentage = String(format: "%.0f", percentage)
        return percentage
    }
    
}
