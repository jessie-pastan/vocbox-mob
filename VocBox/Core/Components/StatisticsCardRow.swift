//
//  AnalyticCardRow.swift
//  VocBox
//
//  Created by Jessie Pastan on 9/29/23.
//

import SwiftUI

struct StatisticsCardRow: View {
    
    var vocabs: FetchedResults<Vocab>
    var scores: FetchedResults<Score>
   
    @ObservedObject var vm = StatisticsViewModel()
    
    var body: some View {
        
        ZStack{
            Rectangle()
            VStack(alignment: .leading){
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
                
                Text("Total Successfull recall : \(vm.totalRecalledString)")
            }
            .padding(.horizontal)
            .foregroundColor(Color.text)
        }
        .foregroundColor(Color.card)
        .cornerRadius(10)
        
         
    }
}
