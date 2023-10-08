//
//  SearchView.swift
//  VocBox
//
//  Created by Jessie Pastan on 10/5/23.
//

import SwiftUI

struct SearchView: View {
    
    
    
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.vocab)]) private var vocabs: FetchedResults<Vocab>
    
    @Environment(\.managedObjectContext) var moc
    @State private var searchedVocabs = ""
    @State private var isShowDefinition = false
    
    @State var selectedVocab  = [Vocab]()
    
    
    var searchResults: [Vocab] {
        if searchedVocabs.isEmpty {
            return Array(vocabs)
        } else {
            return vocabs.filter { $0.vocab?.localizedCaseInsensitiveContains(searchedVocabs) ?? false }
        }
    }
    
    
    var body: some View {
        
        NavigationView {
            
            VStack{
                CustomSearchBar(text: $searchedVocabs)
                    .padding(.bottom, 10)
                    .padding(.horizontal,10)
               List {
                    ForEach(searchResults, id:\.self) { vocab in
                        Button {
                            selectedVocab.append(vocab)
                            isShowDefinition = true
                            print("\(selectedVocab)")
                            
                        } label: {
                            Text(vocab.viewVocab)
                        }
                    }
                    .listRowBackground(Color.card)
                }
                .sheet(isPresented: $isShowDefinition) {
                        DefinitionView(vocab: selectedVocab.first ?? Vocab(context: moc), vocabs: $selectedVocab)
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.background)
    
        }.onAppear{
            selectedVocab.removeAll()
        }
      
       
    }
}

