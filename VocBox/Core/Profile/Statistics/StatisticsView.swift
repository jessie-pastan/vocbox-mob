//
//  StatisticsView.swift
//  VocBox
//
//  Created by Jessie Pastan on 10/3/23.
//

import SwiftUI

struct StatisticsView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.createDate, order: .reverse)]) private var vocabs: FetchedResults<Vocab>
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) private var scores: FetchedResults<Score>
    
    @FetchRequest(
            entity: Vocab.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \Vocab.recall, ascending: false)],
            animation: .default
        ) var mostRecalls: FetchedResults<Vocab>
    
    @FetchRequest(
            entity: Vocab.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \Vocab.recall, ascending: true)],
            animation: .default
        ) var leastRecalls: FetchedResults<Vocab>
    
    @Environment(\.managedObjectContext) var moc
    
    @ObservedObject var vm = StatisticsViewModel()
    
    var body: some View {
        
        VStack{
            Color.background
                .edgesIgnoringSafeArea(.all)
                .overlay {
                   
                        if !scores.isEmpty {
                            VStack(alignment: .leading){
                                
                                ScrollView {
                                    
                                    GeometryReader { proxy in
                                        VStack{
                                            StatisticsCardRow(vocabs: vocabs, scores:scores, vm: vm)
                                            
                                            MostRecallVocabRow(recalls: mostRecalls, vm: vm)
                                            
                                            LeastRecallVocabRow(recalls: leastRecalls, vm: vm)
                                            
                                            TotalVocabRow(vocabs: vocabs, vm: vm)
                                        }
                                    }
                                    .frame(maxWidth: .infinity)
                                    .frame(height:500)
                                    .padding(.horizontal)
                                    
                                }
                                .onAppear{
                                    vm.calculateSuccessRecalledVocab(vocabs: vocabs)
                                    vm.findHighestPercentage(scores: scores, context: moc)
                                    vm.findLastestPercentage(scores: scores, context: moc)
                                    vm.findMostRecallVocab(recalls: mostRecalls)
                                    vm.findLeastRecallVocab(recalls: leastRecalls)
                                }
                                
                                
                            }
                            .padding(.top,40)
                            
                        }else{
                            //TODO: Display card that have a button navigate user to Recall Challenge screen
                            //Text("Recently, have no score yet, please take a challenge")
                            
                            GeometryReader { proxy in
                                TakeAchallengeCard()
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 400)
                            .padding(.horizontal, 30)
                            .padding(.bottom, 70)
                            
                        }
                    
                }
        }
            
        
    }
    
}

#Preview {
    StatisticsView()
}
