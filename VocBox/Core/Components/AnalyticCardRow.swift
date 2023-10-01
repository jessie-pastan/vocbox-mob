//
//  AnalyticCardRow.swift
//  VocBox
//
//  Created by Jessie Pastan on 9/29/23.
//

import SwiftUI

struct AnalyticCardRow: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) private var Scores: FetchedResults<Score>
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.createDate, order: .reverse)]) private var vocabs: FetchedResults<Vocab>
    
    @ObservedObject var vm = AnalyticViewModel()
    
    @Environment(\.managedObjectContext) var moc
    
    @State private var word = ""
  
    var body: some View {
        
        ZStack{
            Rectangle()
            VStack{
                Text("Highest Score")
                HStack{
                    Text("\(vm.heighestDate)")
                    Text("\(vm.heighestPercentage)%")
                    Text("\(vm.heighestScore)/\(vm.heighestScoreVocabAmount)")
                }
                Text("Lastest Score")
                HStack{
                    Text("\(vm.lastestDate)")
                    Text("\(vm.lastestPercentage)%")
                    Text("\(vm.lastestScore)/\(vm.lastestScoreVocabAmount)")
                    
                }
                
                Text("Total Successfull recall \(vm.totalRecalled) words")
            }
            .padding(.horizontal)
            .foregroundColor(Color.text)
        }
        .foregroundColor(Color.card)
        .cornerRadius(10)
        .onAppear{
            vm.calculateSuccessRecalledVocab(vocabs: vocabs)
            vm.findHighestPercentage(scores: Scores, context: moc)
            vm.findLastestPercentage(scores: Scores, context: moc)
            
        }
    }
}

struct AnalyticCardRow_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticCardRow()
    }
}
