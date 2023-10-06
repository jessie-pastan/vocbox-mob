//
//  AnalyticViewModel.swift
//  VocBox
//
//  Created by Jessie Pastan on 9/30/23.
//

import Foundation
import CoreData
import SwiftUI

class StatisticsViewModel: ObservableObject {
    
    @Published var totalRecalled = 0
    @Published var totalRecalledString = ""
    
    @Published var heighestPercentage = ""
    @Published var heighestDate = Date().formatted(date: .abbreviated, time: .omitted)
    @Published var heighestScore: Int64 = 0
    @Published var heighestScoreVocabAmount: Int64 = 0
    
    @Published var lastestPercentage = ""
    @Published var lastestDate = Date().formatted(date: .abbreviated, time: .omitted)
    @Published var lastestScore: Int64 = 0
    @Published var lastestScoreVocabAmount: Int64 = 0
    
    @Published var mostRecalledVocabs = [String]()
    @Published var leastRecalledVocabs = [String]()
             
    @Published var mostRecalledArray = [(String, Int)]()
    @Published var leastRecalledArray = [(String, Int)]()
    
    
    func findHighestPercentage(scores: FetchedResults<Score>, context: NSManagedObjectContext) {
        
        var heighestPercentage = 0.0
        var heighestScoreEntity = Score(context: context)

        for entity in scores {
            if entity.percentage > heighestPercentage {
                heighestPercentage = entity.percentage
                heighestScoreEntity = entity
                let percentageString = String(format: "%.0f", heighestScoreEntity.percentage)
                self.heighestPercentage = percentageString
                self.heighestDate = heighestScoreEntity.viewDate
                self.heighestScore = heighestScoreEntity.score
                self.heighestScoreVocabAmount = heighestScoreEntity.vocabAmount
            }
        }
    }
    
    func findLastestPercentage(scores: FetchedResults<Score>, context: NSManagedObjectContext) {
        if let lastestEntity = scores.first {
            self.lastestDate = lastestEntity.viewDate
            self.lastestScore = lastestEntity.score
            let percentageString = String(format: "%.0f", lastestEntity.percentage)
            self.lastestPercentage = percentageString
            self.lastestScoreVocabAmount = lastestEntity.vocabAmount
        }
    }
    
    
    func calculateSuccessRecalledVocab(vocabs: FetchedResults<Vocab>) {
        var totalRecalled = 0
        
        for entity in vocabs {
            totalRecalled += entity.viewRecall
        }
        
        let wordUnit = addUnitOfRecallString(recall: totalRecalled)
        self.totalRecalledString = "\(String(totalRecalled)) \(wordUnit)"
    }
    
    
    func addUnitOfRecallString(recall : Int) -> String {
        if self.totalRecalled != 0 || self.totalRecalled != 1 {
            return "times"
        }else {
            return "time"
        }
    }
    
    func findMostRecallVocab(recalls: FetchedResults<Vocab>) {
        
        mostRecalledArray = [(String, Int)]()
        for index in 0..<3 {
                let  mostRecall = recalls[index].viewVocab
                let recallTime = recalls[index].viewRecall
                mostRecalledArray.append((mostRecall, recallTime))
            }
        }

    func findLeastRecallVocab(recalls: FetchedResults<Vocab>) {
        leastRecalledArray = [(String, Int)]()
        if recalls.count < 6 {
            for index in 0..<1 {
                let leastRecall = recalls[index].viewVocab
                let recallTime = recalls[index].viewRecall
                leastRecalledArray.append((leastRecall, recallTime))
            }
        }else {
            for index in 0..<3 {
                let leastRecall = recalls[index].viewVocab
                let recallTime = recalls[index].viewRecall
                leastRecalledArray.append((leastRecall, recallTime))
            }
            
        }
    }
    
    
}
