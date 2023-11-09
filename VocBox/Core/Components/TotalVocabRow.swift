//
//  TotalVocabRow.swift
//  VocBox
//
//  Created by Jessie Pastan on 10/3/23.
//

import SwiftUI

struct TotalVocabRow: View {
    
    
    var vocabs: FetchedResults<Vocab>
    var totalRecalled: String

    
    var body: some View {
        
        ZStack{
            Rectangle()
            VStack(alignment: .center){
                
                if  vocabs.count > 1 {
                    Text("📦 \(vocabs.count) Vocabulary words in the box").bold()
                }
                else {
                    Text("📦 \(vocabs.count) Vocabulary word in the box").bold()
                }
                
                Text("✨ Total challenge score : \(totalRecalled)")
                
            }
            
            .padding([.bottom, .top])
            .padding(.horizontal)
            .foregroundColor(Color.text)
        }
       
        .foregroundColor(Color.card)
        .cornerRadius(10)
    }
    
    
}
