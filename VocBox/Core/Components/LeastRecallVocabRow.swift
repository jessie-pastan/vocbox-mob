//
//  LeastRecallVocabRow.swift
//  VocBox
//
//  Created by Jessie Pastan on 10/3/23.
//

import SwiftUI

struct LeastRecallVocabRow: View {
   
    @State private var time = ""
    var leastRecalledArray: [(String, Int)]
    var body: some View {
        
        ZStack {
            Rectangle()
            VStack(alignment: .center) {
                HStack{
                    Text("💭 Least")+Text(leastRecalledArray.count > 1 ? " Words" : " Word")+Text(" Recalled")
                }
                .font(.custom(.playfairBold, size: 17))
                
                ForEach(leastRecalledArray, id: \.0) { vocab in
                    HStack{
                        Text("\(vocab.0) : \(vocab.1)")
                        Text(vocab.1 <= 1 ? "time" : "times")
                    }
                }
            }
            .padding([.bottom,.top])
            .padding(.horizontal)
            .foregroundColor(Color.text)
        }
        
        .foregroundColor(Color.card)
        .cornerRadius(10)
    }
        
}

