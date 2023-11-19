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
    
             
    @Published var mostRecalledArray = [(String, Int)]()
    @Published var leastRecalledArray = [(String, Int)]()
    
    
    func findHighestPercentage(scores: FetchedResults<Score>, context: NSManagedObjectContext) {
        
        var arrayOfAllPercentage = [Double]()
        var highestPercentage: Double = 0
        
        for entity in scores {
            arrayOfAllPercentage.append(entity.percentage)
        }
        
        for percentage in arrayOfAllPercentage {
            if percentage > highestPercentage {
                highestPercentage = percentage
            }
        }
        
        for entity in scores {
            if highestPercentage == entity.percentage {
                let percentageString = String(format: "%.0f", entity.percentage)
                self.heighestPercentage = percentageString
                print("score = \(entity.score)")
                self.heighestScore = entity.score
                print("Self highest score = \(self.heighestScore)")
                self.heighestScoreVocabAmount = entity.vocabAmount
                self.heighestDate = entity.viewDate
               
                
            }
        }
       
    }
    
    func findLastestPercentage(scores: FetchedResults<Score>, context: NSManagedObjectContext) {
        if let lastestEntity = scores.first {
            self.lastestDate = lastestEntity.viewDate
            self.lastestScore = lastestEntity.score
            self.lastestScoreVocabAmount = lastestEntity.vocabAmount
            let percentageString = String(format: "%.0f", lastestEntity.percentage)
            self.lastestPercentage = percentageString
        }
    }
    
    
    //this func reach out to total challenge value in user defaults
    func successRecalledVocab() {
        // Reading the Int value from UserDefaults
        if let savedScore = UserDefaults.standard.object(forKey: AppConstants.totalChallengeScore) as? Int {
            // Value exists and is of the expected type (Int)
            self.totalRecalled = savedScore
            print("Retrieved Int value:", savedScore)
        } else {
            // Value doesn't exist or is not an Int
            print("No valid Int value found for the key:", AppConstants.totalChallengeScore)
        }
    }
    
    
   

    func findMostRecallVocab(recalls: FetchedResults<Vocab>) {
        // find top3 vocabs that user recalled
        // or if there is less than 3 vocab, display all 
        mostRecalledArray = [(String, Int)]()
        if recalls.count >= 3 {
            for index in 0..<3 {
                let  mostRecall = recalls[index].viewVocab
                let recallTime = recalls[index].viewRecall
                mostRecalledArray.append((mostRecall, recallTime))
            }
            
        }
        else{
             for index in (0..<recalls.count) {
                let  mostRecall = recalls[index].viewVocab
                let recallTime = recalls[index].viewRecall
                mostRecalledArray.append((mostRecall, recallTime))
            }
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
    
    // this function verify whether string in least vocab is not redundant in mostRecalledword
    func removedEqualValues(leastRecall: inout [(String, Int)], mostRecall: inout [(String, Int)]) {
        // using inout to be able to update value in array
                leastRecall = leastRecall.filter { aValue in
                    !mostRecall.contains { bValue in
                        aValue == bValue
                    }
                }
        
    }
    
    
}
