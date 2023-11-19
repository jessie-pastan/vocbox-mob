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
    @Environment(\.colorScheme) var colorScheme
    
    @State private var searchedVocabs = ""
    @State private var isShowDefinition = false
    
    @State var selectedVocab: Vocab?
    
   
    
    var searchResults: [Vocab] {
        if searchedVocabs.isEmpty {
            return Array(vocabs)
            
        } else {
            return vocabs.filter { $0.vocab?.localizedCaseInsensitiveContains(searchedVocabs) ?? false }
        }
    }
    
    
    var body: some View {
       /*
        //Option: Implement by built-in Search bar
        NavigationStack {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                List{
                    ForEach(searchResults.indices, id: \.self) { index in
                        Button {
                            selectedVocab = searchResults[index]
                            isShowDefinition.toggle()
                        } label: {
                            Text(searchResults[index].viewVocab)
                        }
                    }
                    .listRowBackground(Color.card)
                }
                .searchable(text: $searchedVocabs, placement: .navigationBarDrawer(displayMode: .always),prompt: "Search")
                .sheet(isPresented: $isShowDefinition) {
                        DefinitionView(selectedVocab: $selectedVocab)
                }
        
            }
            .toolbarBackground(Color(.background))
            .scrollContentBackground(.hidden)
        }
   */
        
        
        //option2: Implement by customSearchBar
        
            VStack {
                
                CustomSearchBar(text: $searchedVocabs)
                    .padding(.top, 20)
                
                if searchResults.isEmpty {
                    List {
                        HStack {
                            Spacer()
                            VStack{
                                if colorScheme == .light {
                                    Image("sad_lightBg")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                }else {
                                    Image("sad_darkBg")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                }
                                
                                Text(vocabs.count == 0 ? "No word yet" : "Not found")
                                    .bold()
                                    .padding(.top, -25)
                            }
                            Spacer()
                        }
                        .listRowBackground(Color.background)
                    }
                    
                }else {
                    List{
                        ForEach(searchResults.indices, id: \.self) { index in
                            Button {
                                selectedVocab = searchResults[index]
                                isShowDefinition.toggle()
                            } label: {
                                Text(searchResults[index].viewVocab)
                            }
                        }
                        .listRowBackground(Color.card)
                        
                    }
                    .sheet(isPresented: $isShowDefinition) {
                        DefinitionView(selectedVocab: $selectedVocab)
                    }
                }
                
                
            }
            
            .scrollContentBackground(.hidden)
            .background(Color.background)
            
       
    }
}

