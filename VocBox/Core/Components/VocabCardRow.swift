//
//  VocabCardRow.swift
//  VocBox
//
//  Created by Jessie P on 9/15/23.
//

import SwiftUI
import AVFoundation


//@available(iOS 17.0, *)
struct VocabCardRow: View {
    @Environment(\.managedObjectContext) var moc
    let synthesizer = AVSpeechSynthesizer()
    var vocab: Vocab
    var vocabulary = "Vocabulary"
    var type = "Noun"
    var phonetic = "Phonetic"
    var definition = "Definition"
    
    @State private var isfavourite: Bool = false
    @State private var trigger = 0
    
    var body: some View {
        
        
        
        ZStack{
                Rectangle()
                HStack{
                    Spacer()
                    VStack {
                        Text(vocab.viewVocab) .font(.custom(.playfairBold, size: 22))
                            
                        Text(vocab.viewPhonetic)
                            
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
                            .onDisappear {
                                moc.refreshAllObjects()
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
                    
                            Image(systemName: "eraser")
        
                        }
                        
                        
                        
                        
                        
                    //This function is not working on iOS17 at 11/2/23 
                    //MARK: Pronunciation speaker
                        Button {
                            // pronounce word when user tap stereo button
                            ReadWord.speakWord(vocabPronunciation: vocab.viewVocab, speechSynthesizer: synthesizer)
                        } label: {
                            Image(systemName: "speaker.wave.2.fill")
                        }
                        
                        
                        
                        
                        //MARK: Favourite word
                        Button {
                            trigger += 1
                            isfavourite = vocab.favourite
                            isfavourite.toggle()
                            CoreDataController().toggleFavouriteVocab(item: vocab, favourite: vocab.favourite, context: moc)
                        } label: {
                            Image(systemName: vocab.favourite ? "heart.fill" : "heart" )
                                .foregroundColor(vocab.favourite ? .red : .black)
                                //.symbolEffect(.bounce, value: trigger)
                        }
                        .onChange(of: isfavourite) { newValue in
                           vocab.favourite = newValue
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
