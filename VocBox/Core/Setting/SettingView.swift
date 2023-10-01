//
//  SettingView.swift
//  VocBox
//
//  Created by Jessie P on 9/21/23.
//

import SwiftUI

struct SettingView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.createDate, order: .reverse)]) private var vocabs: FetchedResults<Vocab>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) private var Scores: FetchedResults<Score>
    
    @Environment(\.managedObjectContext) var moc
    
    @ObservedObject var vm = AnalyticViewModel()
    
    var body: some View {
        
        ScrollView{
            //let heighestScore = vm.findHighestPercentage(scores: Scores, context: moc)
            Text("Total recalled = \(vm.totalRecalledString)")
            HStack{
                Text("Heighest Score = \(vm.heighestPercentage)")
                Text("Date = \(vm.heighestDate)")
                //Text("Lastest Score = \(lastedScore)")
            }
            ForEach(vocabs) { item in
                VStack{
                   
                    HStack{
                        Text(item.viewVocab)
                        Text(String(item.viewRecall))
                        
                        
                    }
                }
            }
            
            
            ForEach(Scores) { item in
                VStack{
                    Text("Challenge Scores")
                    HStack{
                        Text(item.viewDate)
                        Text(String(item.percentage))
                    }
                }
            }
        }
        .onAppear{
            vm.calculateSuccessRecalledVocab(vocabs: vocabs)
            vm.findHighestPercentage(scores: Scores, context: moc)
        }
        
    }
}


