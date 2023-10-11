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
    
    @Binding var selectedVocab: Vocab?
    
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
                Text("\(selectedVocab?.viewVocab ?? "*nil*")").bold().font(.title)
                HStack{
                    Text("\(selectedVocab?.viewType ?? "*nil*")")
                    Text("\(selectedVocab?.viewDefinition ?? "*nil*")")
                }
                Spacer()
            }
        }
    }
}

