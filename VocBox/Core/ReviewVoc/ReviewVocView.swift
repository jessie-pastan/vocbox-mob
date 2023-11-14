//
//  ReviewVocView.swift
//  VocBox
//
//  Created by Jessie P on 9/15/23.
//

import SwiftUI
import CoreData
import StoreKit

//@available(iOS 17.0, *)
struct ReviewVocView: View {

    @FetchRequest(sortDescriptors: [SortDescriptor(\.createDate, order: .reverse)]) private var vocabs: FetchedResults<Vocab>
   // @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) private var scores: FetchedResults<Score>
 
    @EnvironmentObject var storeViewModel : StoreViewModel
    
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.requestReview) var requestReview
    
    @State private var text = ""
    @State private var isShowFavourite = false
    @State private var isShowAll = false
    @State private var isShowAscending = false
    @State private var isShowDescending = false

    @State private var profileViewIsShow = false
    
    @State private var isShowNoFavoriteCard = false
    
    @State private var isShowUpgradeView = false
    
    let position = UUID()
    
    /*
    init() {
        for familyName in UIFont.familyNames {
            print(familyName)
            for fontName in UIFont.fontNames(forFamilyName: familyName) {
                print("-- \(fontName)")
            }
        }
    }
     */
    
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
               }else if isShowAll && vocabs.isEmpty {
                 
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
                    
               if !vocabs.isEmpty  {
                        //MARK: Add new vocabulary button
                        HStack(spacing: 25) {
                            Spacer()
                            
                            if vocabs.count == 20 && storeViewModel.purchasedSubsriptions.isEmpty {
                                Button {
                                    isShowUpgradeView = true
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
                            
                            Spacer()
                        }
                        .padding(.top,5)
                        Spacer()
                    }
                }
               
                .navigationBarBackButtonHidden(true)
                .padding(.bottom,30)
                .padding(.leading, 2)
                .background(Color.background)
           
                //MARK: Verify to display prompt review to user
                //.onAppear(perform: {
                    //if AppReviewManager().canAskForReview(userScore: scores.first?.viewPercentage) {
                        //Task {
                            //try await Task.sleep(until: .now + .seconds(1),
                                                 //tolerance: .seconds(0.5),
                                                 //clock: .suspending)
                            
                           // requestReview()
                            
                       // }
                    //}
                //})
            
                //MARK: Right toolbar for setting profile
           
                .toolbar {
                    ToolbarItem {
                       NavigationLink {
                           ProfileView()
                        }label: {
                            Image(systemName: "person.crop.circle")
                                .foregroundColor(Color(UIColor.label))
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
                            Button("Favorite") {
                                // action: fetch favourite vocabulary
                                isShowFavourite = true
                                // isShowAll = true : is work around for fixing bug happened when delete last favorite code data detect it as empty storage
                                isShowAll = true
                                
                                vocabs.nsPredicate = isShowFavourite ?  NSPredicate(format: "favourite = 1") : nil
                                
                            }
                            
                            /*
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
                             */
                            
                        } label: {
                            Image(systemName: "line.3.horizontal")
                                .foregroundColor(Color(UIColor.label))
                        }
                    }
                }
        }
       .tint(Color(UIColor.label))
       
           
     
       
        
            
       
    
        
        
        
    }
}

@available(iOS 17.0, *)
struct ReviewVocView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewVocView()
    }
}
