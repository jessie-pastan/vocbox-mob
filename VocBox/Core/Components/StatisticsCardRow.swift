//
//  AnalyticCardRow.swift
//  VocBox
//
//  Created by Jessie Pastan on 9/29/23.
//

import SwiftUI

struct StatisticsCardRow: View {
    
    @Environment(\.managedObjectContext) var moc
    
    var heighestPercentage: String
    var heighestDate: String
    var heighestScore: Int64
    var heighestScoreVocabAmount: Int64
    
    var lastestPercentage: String
    var lastestDate: String
    var lastestScore: Int64
    var lastestScoreVocabAmount: Int64
    
    var body: some View {
        
        ZStack{
            Rectangle()
            VStack(alignment: .leading){
                Spacer()
                Text("🏆 Highest Score")
                    .bold()
                HStack{
                    Text("\(heighestDate)")
                    Spacer()
                    Text("\(heighestPercentage)%")
                    Spacer()
                    Text("\(heighestScore)/\(heighestScoreVocabAmount)")
                    Spacer()
                }
                Spacer()
                Text("✨ Latest Score")
                    .bold()
                HStack{
                    
                    Text("\(lastestDate)")
                    Spacer()
                    Text("\(lastestPercentage)%")
                    Spacer()
                    Text("\(lastestScore)/\(lastestScoreVocabAmount)")
                    Spacer()
                }
                Spacer()
                
            }
            .padding([.bottom, .top])
            .padding(.horizontal)
            .foregroundColor(Color.text)
        }
        .foregroundColor(Color.card)
        .cornerRadius(10)
        
         
    }
}
