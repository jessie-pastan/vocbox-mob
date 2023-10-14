//
//  CoredataController.swift
//  VocBox
//
//  Created by Jessie P on 9/14/23.
//

import Foundation
import CoreData
import SwiftUI

class CoreDataController: ObservableObject {
    let container: NSPersistentContainer
    init() {
        //create container with file name when app start
        container = NSPersistentContainer(name:"DataModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("DEBUG: There is error \(error.localizedDescription)")
            }
        }
    }
    
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("DEBUG: data saved!!!!")
        }catch {
            print("DEBUG: We could not save data..")
        }
    }
    
    
    func addUserScore(allVocabAmount: Int, userScore: Int, context: NSManagedObjectContext) {
        
        var scorePercentage: Double {
            let userScore = Double(userScore)
            let allVocab = Double(allVocabAmount)
            let percentage = (userScore / allVocab ) * Double(100)
            return percentage
        }
        
        
        
        let score = Score(context: context)
        score.date = Date()
        score.vocabAmount = Int64(allVocabAmount)
        score.score = Int64(userScore)
        score.percentage = scorePercentage
        
        save(context: context)
        
    }
    
    func addVocab(definition: String, favourite: Bool, phonetic: String, type: String, word: String, context: NSManagedObjectContext) {
        
        let newWord = Vocab(context: context)
        newWord.id = UUID()
        newWord.createDate = Date()
        newWord.vocab = word
        newWord.type = type
        newWord.definition = definition
        newWord.phonetic = phonetic
        newWord.favourite = favourite
        
        save(context: context)
    }
    
    func updateVocabRecall(vocabs: FetchedResults<Vocab> ,successfullRecalledVocab: String, context: NSManagedObjectContext) {
        for item in vocabs {
            print("DeBUG: \(item)")
            //Verify which object is recalled by user
            if item.vocab  == successfullRecalledVocab {
                // Perform your edits recall property
                item.recall += 1
                //print("\(type(of: item.recall))")
                //print("item new recall = \(item.recall)")
                // Save the changes back to Core Data
                save(context: context)
            }
        }
    }
    
    
    func deleteVocab(item: Vocab, context: NSManagedObjectContext) {
        withAnimation {
            context.delete(item)
            save(context: context)
        }
    }
    
    
    func deleteScores(scores: FetchedResults<Score>, context: NSManagedObjectContext) {
        
        for score in scores {
            context.delete(score)
            save(context: context)
        }
         
    }
    
    func editVocab(item: Vocab, vocab: String, favourite: Bool, definition: String, phonetic: String, type: String, context: NSManagedObjectContext) {
        item.vocab = vocab
        item.favourite = favourite
        item.phonetic = phonetic
        item.type = type
        item.definition = definition
        
        save(context: context)
    }
    
    func toggleFavouriteVocab(item: Vocab, favourite: Bool, context: NSManagedObjectContext) {
        item.favourite = !item.favourite
        save(context: context)
    }
    
}
