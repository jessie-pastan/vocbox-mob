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
        VStack(alignment: .leading){
            
            ScrollView{
                
                
                StatisticsCardRow(vocabs: vocabs, scores:scores, vm: vm)
                
                MostRecallVocabRow(recalls: mostRecalls, vm: vm)
                
                LeastRecallVocabRow(recalls: leastRecalls, vm: vm)
                
                
                ForEach(vocabs) { item in
                    VStack{
                        HStack{
                            Text(item.viewVocab)
                            Text(String(item.viewRecall))
    
                        }
                    }
                }
                
    
            }
            .onAppear{
                vm.calculateSuccessRecalledVocab(vocabs: vocabs)
                vm.findHighestPercentage(scores: scores, context: moc)
                vm.findLastestPercentage(scores: scores, context: moc)
                vm.findMostRecallVocab(recalls: mostRecalls)
                vm.findLeastRecallVocab(recalls: leastRecalls)
            }
            
        }
    }
    
}

#Preview {
    StatisticsView()
}
