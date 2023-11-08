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
        /*
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
                    
                    TextField(item.viewDefinition.isEmpty ? "Definition / e.g." : "\(item.viewDefinition)" , text: $definition, axis: .vertical)
                        .padding(10)
                        .frame(width: proxy.size.width / 1.08, height: 75)
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
                            
                        
                            CoreDataController().editVocab(item: item, vocab: trimmedString, favourite: false, definition: definition, phonetic: item.viewPhonetic, type: partOfSpeech.acronym, context: moc)
                            
                            dismiss()
                        }
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
         */
        
        GeometryReader { proxy in
            VStack(alignment: .leading) {
                Text("Edit word")
                    .font(.title2)
                TextField("Word", text: $vocab)
                    .padding(10)
                    .frame(width: proxy.size.width / 1.08, height: 33)
                    .background(Color.textField)
                    .cornerRadius(10)
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
                        
                        // save edited in coreData
                        CoreDataController().editVocab(item: item, vocab: trimmedString, favourite: false, definition: definition, phonetic: self.phonetic, type: partOfSpeech.acronym, context: moc)
                        
                        dismiss()
                        
                    }
                    
                    
                } label: {
                    LongButton(title: "Save", width: proxy.size.width / 1.10, height: 35)
                }
                    
                    
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
