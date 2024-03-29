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

    @State private var statisticsIsShow = false
    @State private var widgetSettingIsShow = false
    @State private var alarmSettingIsShow = false
    
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
                        .frame(height: 500)
                        .padding(.horizontal,40)
                        .padding([.top, .bottom], 60)
                        
                        
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
                                    //force view to update after editing instanlty
                                    .id(index)
                                }
                            }
                        }
                        //Programatically scroll to the top when added new word
                        .onAppear {
                            proxy.scrollTo(0)
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
                    ToolbarItem {
                        Menu {
                            //MARK: Statistic
                           Button("Statistic") {
                                // action: navigate to statictics screen
                               statisticsIsShow =  true
                            }
                            
                            
                            //MARK: Widget Setting
                            Button("Widget") {
                                // action: navigate to widget setting screen
                                widgetSettingIsShow = true
                            }
                            
                            //MARK: Alarm Setting
                            Button("Alarm") {
                                // action: sort A-Z Vocab
                                alarmSettingIsShow = true
                            }
                        
                            
                        } label: {
                            Image(systemName: "person.crop.circle")
                                .foregroundColor(Color.text)
                        }
                        .navigationDestination(isPresented: $statisticsIsShow) {
                            StatisticsView()
                        }
                        .navigationDestination(isPresented: $widgetSettingIsShow) {
                            WidgetSettingView()
                        }
                        .navigationDestination(isPresented: $alarmSettingIsShow) {
                            AlarmSettingView()
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
                                isShowFavourite = false
                                vocabs.nsPredicate = isShowFavourite ? NSPredicate(value: true) : NSPredicate(value: true)
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
                            
                        } label: {
                            Image(systemName: "line.3.horizontal")
                                .foregroundColor(Color.text)
                        }
                        
                    }
                }
            }
            
       
    
        
        
        
    }
}

struct ReviewVocView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewVocView()
    }
}
