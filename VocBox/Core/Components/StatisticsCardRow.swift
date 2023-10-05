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
                Spacer()
                Text("Highest Score")
                    .bold()
                HStack{
                    Text("\(vm.heighestDate)")
                    Text("\(vm.heighestPercentage)%")
                    Text("\(vm.heighestScore)/\(vm.heighestScoreVocabAmount)")
                }
                Spacer()
                Text("Lastest Score")
                    .bold()
                HStack{
                    Text("\(vm.lastestDate)")
                    Text("\(vm.lastestPercentage)%")
                    Text("\(vm.lastestScore)/\(vm.lastestScoreVocabAmount)")
                    
                }
                Spacer()
                
            }
            .padding(.horizontal)
            .foregroundColor(Color.text)
        }
        .foregroundColor(Color.button)
        .cornerRadius(10)
        
         
    }
}
