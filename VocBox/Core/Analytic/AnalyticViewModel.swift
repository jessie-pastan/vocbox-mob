//
//  AnalyticViewModel.swift
//  VocBox
//
//  Created by Jessie Pastan on 9/30/23.
//

import Foundation
import CoreData
import SwiftUI

class AnalyticViewModel: ObservableObject {
    
    @Published var totalRecalled = 0
    @Published var totalRecalledString = ""
    
    @Published var heighestPercentage = 0.0
    @Published var heighestDate = Date().formatted(date: .abbreviated, time: .omitted)
    @Published var heighestScore: Int64 = 0
    @Published var heighestScoreVocabAmount: Int64 = 0
    
    @Published var lastestPercentage = 0.0
    @Published var lastestDate = Date().formatted(date: .abbreviated, time: .omitted)
    @Published var lastestScore: Int64 = 0
    @Published var lastestScoreVocabAmount: Int64 = 0
    
    @Published var mostRecalledVocabs = [String]()
    @Published var leastRecalledVocabs = [String]()
    
    
    func findHighestPercentage(scores: FetchedResults<Score>, context: NSManagedObjectContext) {
        
        var heighestPercentage = 0.0
        var heighestScoreEntity = Score(context: context)

        for entity in scores {
            if entity.percentage > heighestPercentage {
                heighestPercentage = entity.percentage
                heighestScoreEntity = entity
                self.heighestPercentage = heighestScoreEntity.percentage
                self.heighestDate = heighestScoreEntity.viewDate
                self.heighestScore = heighestScoreEntity.score
                self.heighestScoreVocabAmount = heighestScoreEntity.vocabAmount
            }
        }
    }
    
    
    func findLastestPercentage(scores: FetchedResults<Score>, context: NSManagedObjectContext)  {
        if let lastestEntity = scores.first {
            self.lastestDate = lastestEntity.viewDate
            self.lastestScore = lastestEntity.score
            self.lastestPercentage = lastestEntity.percentage
            self.lastestScoreVocabAmount = lastestEntity.vocabAmount
        }
       
    }
    
    
    func calculateSuccessRecalledVocab(vocabs: FetchedResults<Vocab>) {
        var totalRecalled = 0
        
        for entity in vocabs {
            totalRecalled += entity.viewRecall
        }
        
        let wordUnit = addUnitOfRecallString(recall: totalRecalled)
        self.totalRecalledString = " \(String(totalRecalled)) \(wordUnit)"
        
    }
    
    
    func addUnitOfRecallString(recall : Int) -> String {
        if self.totalRecalled != 0 || self.totalRecalled != 1 {
            return "words"
            
        }else{
            return "word"
            
        }
        
    }
    
}
