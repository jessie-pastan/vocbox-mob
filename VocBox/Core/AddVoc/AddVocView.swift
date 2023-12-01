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
    @Environment(\.colorScheme) var colorScheme
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
                    Text("Add New Voc")
                        .font(.title2)
                    Text("Enter word and its definition")
                    GeometryReader { proxy in
                        TextField("Word", text: $vocab)
                            .frame(width: proxy.size.width / 1.08)
                    }
                        .frame(height: 20)
                        .padding(10)
                        .padding(.top, -5)
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
                        .padding(.top, 5)// padding between textfield elements
                        
                        
                    
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
                        GeometryReader { proxy in
                            LongButton(title: "Save", width: proxy.size.width )
                        }
                      
                        .frame(height: 30)
                        
                    }
                    .disabled(vocab.isEmpty)
    
                        
                }
                .fontWeight(.bold)
                .padding()
                
            }
            .background(Color.background)
            .tint(Color(UIColor.label))
    }
}

struct AddVocView_Previews: PreviewProvider {
    static var previews: some View {
        AddVocView()
    }
}
