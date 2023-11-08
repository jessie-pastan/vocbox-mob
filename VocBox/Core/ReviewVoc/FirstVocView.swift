//
//  FirstVocView.swift
//  VocBox
//
//  Created by Jessie Pastan on 11/6/23.
//

import SwiftUI

struct FirstVocView: View {
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.createDate, order: .reverse)]) private var vocabs: FetchedResults<Vocab>
    
    @FetchRequest<Vocab>(sortDescriptors: [], predicate: NSPredicate(format: "favourite == true")) private var favoriteVocabs
    
    var body: some View {
        
        
        
        NavigationStack {
            
            
            if vocabs.isEmpty {
                // show add vocab card
                VStack {
                    VStack{
                        Spacer()
                        GeometryReader { proxy in
                            CreateFirstVocabCard(parentHeight: proxy.size.height)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 400)
                        .padding(.horizontal)
                        .padding(.top, 100)
                        Spacer()
                    }
    
                }
                
            }else {
                // show all existing vocab
                ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack{
                        ForEach(0..<vocabs.count, id: \.self) { index in
                            GeometryReader { proxy in
                                VocabCardRow(vocab: vocabs[index])
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .padding(.horizontal)
                           //force scrollview to roll to the top
                            .id(index)
                        }
                    }
                    //force view to update after editing instanlty
                    .id(UUID())
                }
                
                //Programatically scroll to the top when added new word
                .onAppear {
                    proxy.scrollTo(0)
                }
                    
                    
                    
            }
                
              
                
                
            
            }
            
            
        }
        
    }
}

#Preview {
    FirstVocView()
}
