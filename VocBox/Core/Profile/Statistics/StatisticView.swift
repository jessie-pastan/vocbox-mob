//
//  StatisticView.swift
//  VocBox
//
//  Created by Jessie Pastan on 10/12/23.
//

import SwiftUI

struct StatisticView: View {
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
    
    
    @StateObject var vm = StatisticsViewModel()
    @Environment(\.managedObjectContext) var moc
    
    
    var body: some View {
        
        
        VStack{
            
            Color.background
                .edgesIgnoringSafeArea(.all)
                .overlay {
                    if !scores.isEmpty {
                        
                        VStack(alignment: .leading) {
                            
                            Text("Statistic").font(.custom(.playfairBold, size: 28))
                                .padding(.leading)
                            
                            ScrollView {
                                
                                GeometryReader { proxy in
                                    VStack{
                                        
                                        StatisticsCardRow(heighestPercentage: vm.heighestPercentage, heighestDate: vm.heighestDate, heighestScore: vm.heighestScore, heighestScoreVocabAmount: vm.heighestScoreVocabAmount, lastestPercentage: vm.lastestPercentage, lastestDate: vm.lastestDate, lastestScore: vm.lastestScore, lastestScoreVocabAmount: vm.lastestScoreVocabAmount)
                                        
                                        TotalVocabRow(vocabs: vocabs, totalRecalled: vm.totalRecalled)
                                        
                                        MostRecallVocabRow(mostRecalledArray: vm.mostRecalledArray)
                                        LeastRecallVocabRow(leastRecalledArray: vm.leastRecalledArray)
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height:500)
                                .padding(.horizontal)
                            }
                        }
                        .task {
                            vm.successRecalledVocab()
                            vm.findHighestPercentage(scores: scores, context: moc)
                            vm.findLastestPercentage(scores: scores, context: moc)
                            vm.findMostRecallVocab(recalls: mostRecalls)
                            vm.findLeastRecallVocab(recalls: leastRecalls)
                        }
                        .padding(.top,40)
                        
                    }else{
                        //MARK: Display card to let user know that they have no record yet
                        
                        GeometryReader { proxy in
                            
                            TakeAchallengeCard()
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 400)
                        .padding(.horizontal, 30)
                        .padding(.bottom, 70)
                    }
                }
        }.onAppear{
            CrashManager.shared.addLog(message: "statistic view appeared on user's screen")
        }
    }
}

#Preview {
    StatisticView()
}
