//
//  ReviewVocView.swift
//  VocBox
//
//  Created by Jessie P on 9/15/23.
//

import SwiftUI
import CoreData

@available(iOS 17.0, *)
struct ReviewVocView: View {
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.createDate, order: .reverse)]) private var vocabs: FetchedResults<Vocab>

    
    @Environment(\.managedObjectContext) var moc
    
    @State private var text = ""
    @State private var isShowFavourite = false
    @State private var isShowAll = false
    @State private var isShowAscending = false
    @State private var isShowDescending = false

    @State private var profileViewIsShow = false
    
    let position = UUID()
    
    var body: some View {
        NavigationStack{
           
                VStack {
                    Spacer()
                    if vocabs.isEmpty {
                        GeometryReader { _ in
                            CreateFirstVocabCard()
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 400)
                        .padding(.horizontal, 30)
                        .padding(.top, 70)
                        
                    }
                    //MARK: All vocabulary
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
                    
                    Spacer()
                    if !vocabs.isEmpty {
                        //MARK: Add new vocabulary button
                        HStack(spacing: 25) {
                            Spacer()
                            NavigationLink {
                                AddVocView()
                            } label: {
                                GeometryReader { proxy in
                                    SmallButton(title: "Add word")
                                }
                                .frame(height: 44)
                                
                            }
                            Spacer()
                            //MARK: Brain Challenge button
                            NavigationLink {
                                RecallVocView()
                            } label: {
                                GeometryReader { proxy in
                                    SmallButton(title: "Recall Challenge")
                                }
                                .frame(height: 44)
                            }
                            
                            Spacer()
                        }
                        .padding(.top,5)
                        Spacer()
                    }
                }
                .padding(.bottom,30)
                .padding(.leading, 2)
                .background(Color.background)
            
                //MARK: Right toolbar for setting profile
            
                .toolbar {
                    ToolbarItem {
                        Button {
                            profileViewIsShow  = true
                        }label: {
                            Image(systemName: "person.crop.circle")
                                .foregroundColor(vocabs.isEmpty ? (Color.gray) : Color(UIColor.label))
                        }
                        .disabled(vocabs.isEmpty)
                        .navigationDestination(isPresented: $profileViewIsShow) {
                           ProfileView()
                        }
                    }
                }
             
        
                //MARK: Left toolbar for filtering vocabulary
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading){
                        Menu {
                            //MARK: All Vocab
                           
                            Button("All") {
                                // action: sort Vocab by recently added
                                isShowAll.toggle()
                                vocabs.nsPredicate = isShowAll ? NSPredicate(value: true) : NSPredicate(value: true)
                            }
                            
                            
                            //MARK: Filter favourite
                            Button("Favourite") {
                                // action: fetch favourite vocabulary
                                isShowFavourite = true
                                vocabs.nsPredicate = isShowFavourite ?  NSPredicate(format: "favourite = 1") : nil
                            }
                            
                            
                            //MARK: sort A-Z Order
                            Button("A-Z") {
                                // action: sort A-Z Vocab
                               isShowAscending = true
                                
                                vocabs.nsPredicate = isShowAscending ? NSPredicate(value: true) : NSPredicate(value: true)
                                vocabs.sortDescriptors = [SortDescriptor(\.vocab)]
                               
                            }
                            //MARK: sort Z-A Order
                            Button("Z-A") {
                                // action: sort Z-A Vocab
                               isShowDescending = true
                                vocabs.nsPredicate = isShowDescending ? NSPredicate(value: true) : NSPredicate(value: true)
                                vocabs.sortDescriptors = [SortDescriptor(\.vocab, order: .reverse)]
                            }
                            
                        } label: {
                            Image(systemName: "line.3.horizontal")
                                .foregroundColor(Color(UIColor.label))
                        }
                        
                    }
                }
        }.tint(Color(UIColor.label))
            
       
    
        
        
        
    }
}

@available(iOS 17.0, *)
struct ReviewVocView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewVocView()
    }
}
