//
//  AddVocViewModel.swift
//  VocBox
//
//  Created by Jessie P on 9/21/23.
//

import Foundation

@MainActor
class AddVocViewModel: ObservableObject {

    func fetchPhonetic(vocab: String) async throws -> String {
        return try! await FetchData().fetchVocabPhonetic(vocab: vocab)
    }
    /*
    func fetchPronunciation(vocab: String, vocabType: String) async throws -> String {
        let lowerType = vocabType.lowercased()
        return try! await FetchData().fetchVocabPronunciation(vocab: vocab, vocabType: lowerType)
    }
     */
         
    
}
