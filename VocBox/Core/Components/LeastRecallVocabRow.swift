//
//  LeastRecallVocabRow.swift
//  VocBox
//
//  Created by Jessie Pastan on 10/3/23.
//

import SwiftUI

struct LeastRecallVocabRow: View {
    var recalls: FetchedResults<Vocab>
    @ObservedObject var vm = StatisticsViewModel()
    @State private var time = ""
    
    var body: some View {
        
        ZStack {
            Rectangle()
            VStack(alignment: .center) {
                
                Text("Least Recalled")
                ForEach(vm.leastRecalledArray, id: \.0) { vocab in
                    HStack{
                        Text("\(vocab.0) : \(vocab.1)")
                        Text(vocab.1 <= 1 ? "time" : "times")
                    }
                }
            }
            .padding(.horizontal)
            .foregroundColor(Color.text)
        }
        .foregroundColor(Color.button)
        .cornerRadius(10)
    }
        
}

