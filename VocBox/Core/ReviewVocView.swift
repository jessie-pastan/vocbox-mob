//
//  ReviewVocView.swift
//  VocBox
//
//  Created by Jessie P on 9/15/23.
//

import SwiftUI
import CoreData

struct ReviewVocView: View {

    @FetchRequest(sortDescriptors: [SortDescriptor(\.createDate, order: .reverse)]) private var vocabs: FetchedResults<Vocab>
    
    @Environment(\.managedObjectContext) var moc
    
    @State private var text = ""
    @State private var isShowFavourite = false
    @State private var isShowAll = false
    @State private var isShowAscending = false
    @State private var isShowDescending = false
    
    @Binding var scrollToTop: Bool
    @State private var scrollProxy: ScrollViewProxy? = nil
    @State private var trigger = 0
    
    
    var body: some View {
        NavigationStack{
            //GeometryReader {_ in
                VStack {
                    Spacer()
                    if vocabs.isEmpty {
                        GeometryReader { _ in
                            CreateFirstVocabCard()
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 500)
                        .padding(.horizontal,40)
                        .padding([.top, .bottom], 60)
                        
                        
                    }
                    //MARK: All vocabulary
                    ScrollViewReader { proxy in
                        ScrollView {
                            
                            
                            LazyVStack{
                                ForEach(vocabs) { vocab in
                                    GeometryReader { proxy in
                                        VocabCardRow(vocab: vocab)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 200)
                                    .padding(.horizontal)
                                }
                            }
                            //force view to update after editing instanlty
                            .id(UUID())
                            
                            
                        }
                        .background(
                            GeometryReader { geometry in
                                Color.clear.onAppear {
                                    if scrollToTop {
                                        proxy.scrollTo(0, anchor: .top)
                                        scrollToTop = false
                                    }
                                }
                            }
                        )
                        .onAppear {
                            scrollProxy = proxy
                        }
                        
                    }
                    
                    Spacer()
                    
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
                                SmallButton(title: "Brain Challenge")
                            }
                            .frame(height: 44)
                        }
                        
                        Spacer()
                    }
                    .padding(.top,5)
                    Spacer()
                }
                .padding(.bottom,30)
                .padding(.leading, 2)
                .background(Color.background)
                //MARK: Right toolbar for setting profile
                .toolbar {
                    NavigationLink {
                        //TODO: navigate to setting view
                        SettingView()
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(Color.text)
                    }
                }
                //MARK: Left toolbar for filtering vocabulary
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading){
                        
                        Button {
                            isShowFavourite.toggle()
                            trigger += 1
                            vocabs.nsPredicate = isShowFavourite ?  NSPredicate(format: "favourite == 1") : NSPredicate(value: true)

                            /*
                            //MARK: All Vocab
                            Button("All") {
                                // action: sort Vocab by recently added
                                isShowAll = true
                                vocabs.nsPredicate = isShowAll ? NSPredicate(value: true) : NSPredicate(value: true)
                                vocabs.sortDescriptors = [SortDescriptor(\.createDate, order: .reverse)]
                            }
                            
                            
                            //MARK: Filter favourite
                            Button("Favourite") {
                                // action: fetch favourite vocabulary
                                isShowFavourite = true
                                vocabs.nsPredicate = isShowFavourite ?  NSPredicate(format: "favourite == 1") : NSPredicate(value: true)
                            }
                            
                            //MARK: sort A-Z Order
                            Button("A-Z") {
                                // action: sort A-Z Vocab
                                isShowFavourite = false
                                vocabs.nsPredicate = isShowFavourite ? NSPredicate(value: true) : NSPredicate(value: true)
                                vocabs.sortDescriptors = [SortDescriptor(\.vocab, order: .forward)]
                            }
                            //MARK: sort Z-A Order
                            Button("Z-A") {
                                // action: sort Z-A Vocab
                                isShowFavourite = false
                                vocabs.nsPredicate = isShowFavourite ? NSPredicate(value: true) : NSPredicate(value: true)
                                vocabs.sortDescriptors = [SortDescriptor(\.vocab, order: .reverse)]
                            }
                            */
                        } label: {
                            Image(systemName: isShowFavourite ? "heart.circle.fill" : "heart.circle" )
                                .foregroundColor(isShowFavourite ? .red : .black)
                                .symbolEffect(.bounce, value: trigger)
                        }
                            
                             
                        
                    }
                }
            }
            
        //}
    
        
        
        
    }
}

struct ReviewVocView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewVocView(scrollToTop: .constant(true))
    }
}
