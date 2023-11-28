//
//  ReviewVocView.swift
//  VocBox
//
//  Created by Jessie P on 9/15/23.
//

import SwiftUI
import CoreData
import StoreKit


struct ReviewVocView: View {

    @FetchRequest(sortDescriptors: [SortDescriptor(\.createDate, order: .reverse)]) private var vocabs: FetchedResults<Vocab>

    @EnvironmentObject var storeViewModel: StoreViewModel
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.colorScheme) var colorScheme
    
    @State private var text = ""
    @State private var isShowFavourite = false
    @State private var isShowAll = false
    @State private var isShowAscending = false
    @State private var isShowDescending = false
    
    @State private var isShowNoFavoriteCard = false
    @State private var isShowUpgradeView = false
    @State private var allVocab = [Vocab]()
    
    let position = UUID()
    
    var body: some View {
        
       NavigationStack{
       
           VStack {
               Spacer()
               //MARK: Display CreateFirstVocabCard if Vocabulary storage empty
               if vocabs.isEmpty && isShowAll == false {
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
                   //MARK: show No favorite card
               }else if isShowFavourite && vocabs.isEmpty {
                 
                       GeometryReader { proxy in
                           VStack{
                               Spacer()
                               NoFavoriteCard()
                                   .frame(width: proxy.size.width, height: proxy.size.height * 1.25 )
                                   .position(x: proxy.size.width / 2, y: proxy.size.height )
                               Spacer()
                           }
                       }
                       .padding(.horizontal)

               }
                    
                    //MARK: Display All vocabulary
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
                    
               if !vocabs.isEmpty  {
                        //MARK: Add new vocabulary button
                        HStack(spacing: 25) {
                            Spacer()
                            
                            if allVocab.count == 20 || vocabs.count == 20 && storeViewModel.purchasedSubsriptions.isEmpty {
                                Button {
                                    isShowUpgradeView = true
                                    CrashManager.shared.addLog(message: "Add button tapped (user haven't purchase pro)")
                                } label: {
                                    GeometryReader { proxy in
                                        SmallButton(title: "Add")
                                    }
                                    .frame(height: 44)
                                }
                                .sheet(isPresented: $isShowUpgradeView) {
                                    
                                } content: {
                                    ProUpgradeView()
                                }

                            }else {
                                NavigationLink {
                                    AddVocView()
                                } label: {
                                    GeometryReader { proxy in
                                        SmallButton(title: "Add")
                                    }
                                    .frame(height: 44)
                                }
                                .onTapGesture {
                                    CrashManager.shared.addLog(message: "Add button tapped")
                                }
                                
                            }
                            
            
                            Spacer()
                            //MARK: Brain Challenge button
                            NavigationLink {
                                RecallVocView()
                            } label: {
                                GeometryReader { proxy in
                                    SmallButton(title: "Challenge")
                                }
                               
                                .frame(height: 44)
                            }
                            .onTapGesture {
                                CrashManager.shared.addLog(message: "Challenge button tapped")
                            }
                            
                            Spacer()
                        }
                        .padding(.top,5)
                        Spacer()
                    }
                }
                .onAppear(perform: {
                    CrashManager.shared.addLog(message: "ReviewVocView appeared on user's screen")
                    })
                .navigationBarBackButtonHidden(true)
                .padding(.bottom,30)
                .padding(.leading, 2)
                .background(Color.background)
                
            
                //MARK: Right toolbar for setting profile
           
                .toolbar {
                    ToolbarItem {
                       NavigationLink {
                           ProfileView()
                        }label: {
                            Image(systemName: "person.crop.circle")
                                .foregroundColor(vocabs.isEmpty ? Color.gray : Color(UIColor.label))
                        }
                        .disabled(vocabs.isEmpty)
                        .onTapGesture {
                            CrashManager.shared.addLog(message: "Profile icon tapped")
                        }
                    }
                    
                }
             
        
                //MARK: Left toolbar for filtering vocabulary
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading){
                    
                        Menu {
                            //MARK: All Vocab
                           
                            Button("All") {
                                CrashManager.shared.addLog(message: "All vocab button tapped")
                                // action: sort Vocab by recently added
                                //isShowAll.toggle()
                                vocabs.nsPredicate = isShowAll ? NSPredicate(value: true) : NSPredicate(value: true)
                            }
                            
                           
                            //MARK: Filter favourite
                            Button("Favorites") {
                                CrashManager.shared.addLog(message: "Favorite vocab button tapped")
                                // action: fetch favourite vocabulary
                                isShowFavourite = true
                                // isShowAll = true : is work around for fixing bug happened when delete last favorite code data detect it as empty storage
                                isShowAll = true
                                
                                //counting vocab when user tap on favourites to verify pro upgrade
                                allVocab = ReviewVocViewModel().fetchData(viewContext: moc)
                                
                                vocabs.nsPredicate = isShowFavourite ?  NSPredicate(format: "favourite = 1") : nil
                                
                            }
                            
                        } label: {
                            Image(systemName: "line.3.horizontal")
                                .foregroundColor(Color(UIColor.label))
                        }
                        .onTapGesture {
                            CrashManager.shared.addLog(message: "3 lines icon tapped")
                        }
                        
                    
                    }
                }
        }
      
       .tint(Color(UIColor.label))
       
    }
    
}


struct ReviewVocView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewVocView()
    }
}
