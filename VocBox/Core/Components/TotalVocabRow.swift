//
//  TotalVocabRow.swift
//  VocBox
//
//  Created by Jessie Pastan on 10/3/23.
//

import SwiftUI

struct TotalVocabRow: View {
    
    
    var vocabs: FetchedResults<Vocab>
    var totalRecalled: Int

    
    var body: some View {
        
        ZStack{
            Rectangle()
            VStack(alignment: .center){
                
                if  vocabs.count > 1 {
                    Text("📦 \(vocabs.count)").font(.headline) + Text(" Vocabulary words in the box").font(.custom(.playfairBold, size: 17))
                }
                else {
                    Text("📦 \(vocabs.count)").font(.headline) + Text(" Vocabulary word in the box").font(.custom(.playfairBold, size: 17))
                }
                
                HStack {
                    Text("🌟 Total challenge score :").font(.custom(.playfairBold, size: 17)) + Text(" \(totalRecalled)")
                }
            }
            
            .padding([.bottom, .top])
            .padding(.horizontal)
            .foregroundColor(Color.text)
        }
       
        .foregroundColor(Color.card)
        .cornerRadius(10)
    }
    
    
}
