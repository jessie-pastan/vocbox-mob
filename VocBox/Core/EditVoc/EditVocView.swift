//
//  EditVocView.swift
//  VocBox
//
//  Created by Jessie P on 9/14/23.
//

import SwiftUI
import CoreData
import UIKit

struct EditVocView: View {
    
    var item: Vocab
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var vm = AddVocViewModel()
    
    
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
                Text("Edit word")
                    .font(.title2)
                GeometryReader{ proxy in
                    TextField("Word", text: $vocab)
                        .frame(width: proxy.size.width / 1.08)
                        
                }
                .frame(height: 20)
                .padding(10)// padding for cursor
                .padding(.top, -5)// padding of text in text field
                    .background(Color.textField)
                    .cornerRadius(10)
                    //.padding(.bottom, 10)// space between each text fields
                    .onAppear{
                        vocab = item.viewVocab
                        definition = item.viewDefinition
            
                        let part = PartOfSpeechType.types.filter {  type  in
                            type.acronym == item.viewType
                        }
                        partOfSpeech = part.first ?? PartOfSpeechType.types.first!
                    }
                    
                    

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
                                    .font(.caption)
                                    .lineLimit(1)
                                    .foregroundColor(Color.text)
                                    .padding(7)
                                    .background(partOfSpeech.id == item.id ? Color.selectedPartOfSpeech : Color.button)
                                    .cornerRadius(10)
                            }
                            .background(Rectangle().foregroundColor(Color(colorScheme == .light ? .textField : .buttonShadowDarkMode)).cornerRadius(10).offset(x: 2, y: 2))
                            
                        }
                    }
                }
                
                GeometryReader { proxy in
                    TextField("Definition / e.g.", text: $definition, axis: .vertical)
                        .frame(width: proxy.size.width / 1.08)
                        
                }
                    .frame(height: 40)
                    .padding(10)
                    .padding(.top, 15)
                    .multilineTextAlignment(.leading)
                    .background(Color.textField)
                    .cornerRadius(10)
                    .padding(.top, 5)
                    
                    
                
                //MARK: Save button
                Button {
                    
                    
                    //trim vocab to uniform String with no space and "" from predictive keyboard
                    let trimmedString = TrimString.trimString(input: vocab)
                    
                    Task{
                        //fetch phonetic from api
                        self.phonetic = try await vm.fetchPhonetic(vocab: trimmedString)
                        
                        // save edited in coreData
                        CoreDataController().editVocab(item: item, vocab: trimmedString, favourite: item.viewFavourite, definition: definition, phonetic: self.phonetic, type: partOfSpeech.acronym, context: moc)
                        
                       
                        dismiss()
                        
                    }
                    
                    
                } label: {
                    GeometryReader { proxy in
                        LongButton(title: "Save", width: proxy.size.width)
                    }
                    .frame(height: 30)
                   
                }
                .disabled(vocab.isEmpty)
                    
                    
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
