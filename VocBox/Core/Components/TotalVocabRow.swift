//
//  TotalVocabRow.swift
//  VocBox
//
//  Created by Jessie Pastan on 10/3/23.
//

import SwiftUI

struct TotalVocabRow: View {
    
    
    var vocabs: FetchedResults<Vocab>
    
    @ObservedObject var vm = StatisticsViewModel()
    
    var body: some View {
        
        ZStack{
            Rectangle()
            VStack(alignment: .center){
                Text("\(vocabs.count) Voc in the box")
                
                Text("Total Successfull recall : \(vm.totalRecalledString)")
            }
            
            .padding([.bottom, .top])
            .padding(.horizontal)
            .foregroundColor(Color.text)
        }
       
        .foregroundColor(Color.card)
        .cornerRadius(10)
    }
    
    
}
