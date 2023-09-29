//
//  EditVocView.swift
//  VocBox
//
//  Created by Jessie P on 9/14/23.
//

import SwiftUI

struct EditVocView: View {
    
    var item: Vocab
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    
    
    @State  var vocab = ""
    @State  var partOfSpeech: PartOfSpeechType = PartOfSpeechType.types.first!
    @State  var definition = ""
    @State  var phonetic = "/fəˈnedik/"
    
    let colums: [GridItem] = [GridItem(.adaptive(minimum: 100, maximum: 300)),
                              GridItem(.adaptive(minimum: 100, maximum: 300)),
                              GridItem(.adaptive(minimum: 100, maximum: 300))
                              ]
    
    var body: some View {
            GeometryReader { proxy in
                VStack(alignment: .leading) {
                    Text("Edit Word")
                        .font(.title2)
                    TextField("\(item.viewVocab)", text: $vocab)
                    
                        .onAppear{
                            vocab = item.viewVocab
                            definition = item.viewDefinition
                
                            let part = PartOfSpeechType.types.filter {  type  in
                                type.acronym == item.viewType
                            }
                            partOfSpeech = part.first ?? PartOfSpeechType.types.first!
                        }
                    
                        .padding(10)
                        .frame(width: proxy.size.width / 1.08, height: 39)
                        .background(Color.textField)
                        .cornerRadius(10)
                        
                    
                    Text("Add part of Speech")

                    //MARK: PartOfSpeech buttons
                    LazyVGrid(columns: colums) {
                        ForEach(PartOfSpeechType.types) { item in
                            HStack{
                                Button {
                                    withAnimation(.spring()) {
                                        partOfSpeech = item
                                    }
                                } label: {
                                    Text(item.title)
                                        .lineLimit(1)
                                        .foregroundColor(Color.text)
                                        .padding(7)
                                        .background(partOfSpeech.id == item.id ? Color.card : Color.button)
                                        .cornerRadius(10)
                                }
                                .background(Rectangle().foregroundColor(.textField).cornerRadius(10).offset(x: 2, y: 2))
                                
                            }
                        }
                    }
                    
                    TextField("\(item.viewDefinition)", text: $definition, axis: .vertical)
                        .padding(10)
                        .frame(width: proxy.size.width / 1.08, height: 75)
                        .multilineTextAlignment(.leading)
                        .background(Color.textField)
                        .cornerRadius(10)
                        .padding(.top,10)
                        
                        
                    
                    //MARK: Save button
                    Button {
                        
                        CoreDataController().editVocab(item: item, vocab: vocab, favourite: false, definition: definition, phonetic: item.viewPhonetic, type: partOfSpeech.acronym, context: moc)
                        
                        dismiss()
                    } label: {
                        
                            Text("Save")
                                .lineLimit(1)
                                .frame(width: proxy.size.width / 1.10, height: 44)
                                .foregroundColor(Color.text)
                                .padding(7)
                                .background(Color.button)
                                .cornerRadius(120)
                        }
                        .background(Rectangle().foregroundColor(.textField).cornerRadius(120).offset(x: 2, y: 2))
                        .padding(.top, 5)
                        .padding(.leading, -5)
                    

                        
                }
                .fontWeight(.bold)
                .padding()
                
            }
            .background(Color.background)
    }
}

/*
 struct EditVocView_Previews: PreviewProvider {
 static var previews: some View {
 EditVocView()
 }
 }
 */
