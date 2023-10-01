//
//  VocabCardRow.swift
//  VocBox
//
//  Created by Jessie P on 9/15/23.
//

import SwiftUI

struct VocabCardRow: View {
    @Environment(\.managedObjectContext) var moc
   
    var vocab: Vocab
    var vocabulary = "Vocabulary"
    var type = "Noun"
    var phonetic = "Phonetic"
    var definition = "Definition"
    
    @State private var isfavourite: Bool = false
    
    var body: some View {
        
            ZStack{
                Rectangle()
                HStack{
                    Spacer()
                    VStack {
                        Text(vocab.viewVocab).fontWeight(.bold).font(.title2)
                        HStack(spacing: 5){
                           

                            Text(vocab.viewPhonetic)
                            
                        }
                        Text("(\(vocab.viewType)) \(vocab.viewDefinition)")
                        .padding(.top, 10)
                        
                    }
                    .padding(.leading,30)
                    Spacer()
                    
                    //MARK: Menu drop down for Editing and Delete
                    VStack(spacing: 60){
                        
                        Menu {
                            NavigationLink {
                                //Edit word
                                EditVocView(item: vocab)
                            } label: {
                                HStack{
                                    Text("Edit")
                                    Spacer()
                                    Image(systemName: "pencil")
                                }
                            }
                            
                            Button(role: .destructive) {
                                //Delete word
                                CoreDataController().deleteVocab(item: vocab, context: moc)
                            } label: {
                                HStack{
                                    Text("Delete")
                                    Spacer()
                                    Image(systemName: "trash")
                                }
                            }
                            
                        } label: {
                            Image(systemName: "ellipsis")
                                .rotationEffect(.degrees(90))
                        }
                        
                        
                        
                        
                        
                        
                    //MARK: Pronunciation speaker
                        Button {
                            // pronounce word when user tap
                        } label: {
                            Image(systemName: "speaker.wave.2.fill")
                            
                        }
                        
                        
                        
                        
                        //MARK: Favourite word
                        Button {
                            isfavourite.toggle()
                            CoreDataController().toggleFavouriteVocab(item: vocab, favourite: isfavourite, context: moc)
                        } label: {
                            Image(systemName: vocab.favourite ? "heart.fill" : "heart" )
                                .foregroundColor(vocab.favourite ? .red : .black)
                        }
                        
                    }
                    
                }
                .padding(.horizontal)
                .foregroundColor(Color.text)
            }
            .foregroundColor(Color.card)
            .cornerRadius(10)
        }
    
    
    }


//struct VocabCardRow_Previews: PreviewProvider {
    //static var previews: some View {
        //VocabCardRow()
    //}
//}
