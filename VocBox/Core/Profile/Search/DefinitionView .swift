//
//  DefinitionView .swift
//  VocBox
//
//  Created by Jessie Pastan on 10/6/23.
//

import SwiftUI

struct DefinitionView: View {
    
    @Environment(\.dismiss) var dissmiss
    @Environment(\.colorScheme) var colorScheme

    var vocab: Vocab
    
    @Binding var vocabs: [Vocab]
    
    var body: some View {
        ZStack {

            Color.background
            .ignoresSafeArea()
            
            VStack{
                
                HStack{
                    Spacer()
                    Button {
                        dissmiss()
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .foregroundColor(Color(UIColor.label))
                    }
                    .padding()
                }
                Spacer()
                Text(vocab.viewVocab).bold().font(.title)
                HStack{
                    Text(vocab.viewType)
                    Text(vocab.viewDefinition)
                }
                Spacer()
            }
            
        }
        .onDisappear{
           vocabs.removeAll()
        }
    }
}

