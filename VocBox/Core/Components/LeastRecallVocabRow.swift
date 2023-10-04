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
                
                Text("Least Recalled Vocabulary")
                ForEach(vm.leastRecalledArray, id: \.0) { vocab in
                    HStack{
                        Text("\(vocab.0) : \(vocab.1)")
                        Text(vocab.1 <= 1 ? "Time" : "Times")
                    }
                }
            }
            .padding(.horizontal)
            .foregroundColor(Color.text)
        }
        .foregroundColor(Color.card)
        .cornerRadius(10)
    }
        
}

