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
         
    
}
