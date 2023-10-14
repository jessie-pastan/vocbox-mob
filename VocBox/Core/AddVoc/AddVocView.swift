//
//  AddVocView.swift
//  VocBox
//
//  Created by Jessie P on 9/14/23.
//

import SwiftUI

struct AddVocView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm = AddVocViewModel()
    
    @State private var vocab = ""
    @State private var partOfSpeech: PartOfSpeechType = PartOfSpeechType.types.first!
    @State private var definition = ""
    @State private var phonetic = "/fəˈnedik/"
    
    let colums: [GridItem] = [GridItem(.adaptive(minimum: 100, maximum: 300)),
                              GridItem(.adaptive(minimum: 100, maximum: 300)),
                              GridItem(.adaptive(minimum: 100, maximum: 300))
                              ]
    
    var body: some View {
        
       
            GeometryReader { proxy in
                VStack(alignment: .leading) {
                    Text("Add New word")
                        .font(.title2)
                    Text("Enter word and its definition")
                    TextField("Word", text: $vocab)
                        .padding(10)
                        .frame(width: proxy.size.width / 1.08, height: 33)
                        .background(Color.textField)
                        .cornerRadius(10)
                        
                        

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
                                        .background(partOfSpeech.id == item.id ? Color.card : Color.button)
                                        .cornerRadius(10)
                                }
                                .background(Rectangle().foregroundColor(.textField).cornerRadius(10).offset(x: 2, y: 2))
                                
                            }
                        }
                    }
                    
                    TextField("Definition / e.g.", text: $definition, axis: .vertical)
                        .padding(10)
                        .frame(width: proxy.size.width / 1.08, height: 60)
                        .multilineTextAlignment(.leading)
                        .background(Color.textField)
                        .cornerRadius(10)
                        .padding(.top,10)
                        
                        
                    
                    //MARK: Save button
                    Button {
                        //trim vocab to uniform String with no space and "" from predictive keyboard
                        let trimmedString = TrimString.trimString(input: vocab)
                        
                        Task{
                            //fetch phonetic from api
                            self.phonetic = try await vm.fetchPhonetic(vocab: trimmedString)
                            
                            // save in coreData
                            CoreDataController().addVocab(definition: definition, favourite: false, phonetic: phonetic, type: partOfSpeech.acronym, word: trimmedString.capitalized, context: moc)
                            
                            dismiss()
                            
                        }
                        
                        
                    } label: {
                        
                            Text("Save")
                                .lineLimit(1)
                                .frame(width: proxy.size.width / 1.10, height: 35)
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

struct AddVocView_Previews: PreviewProvider {
    static var previews: some View {
        AddVocView()
    }
}
