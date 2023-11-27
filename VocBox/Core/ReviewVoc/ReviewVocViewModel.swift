//
//  ReviewVocViewModel.swift
//  VocBox
//
//  Created by Jessie Pastan on 11/25/23.
//

import Foundation
import CoreData

class ReviewVocViewModel {
    
    func fetchData(viewContext: NSManagedObjectContext) -> [Vocab] {
        var vocab = [Vocab]()
          let request: NSFetchRequest<Vocab> = Vocab.fetchRequest() // Replace Vocab with your entity
          do {
            vocab = try viewContext.fetch(request)
          } catch {
              print("Error fetching data: \(error.localizedDescription)")
          }
        return vocab
      }
    
    
}
