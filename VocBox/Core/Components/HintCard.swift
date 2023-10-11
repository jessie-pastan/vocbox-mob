//
//  HintCard.swift
//  VocBox
//
//  Created by Jessie Pastan on 10/7/23.
//

import SwiftUI

struct HintCard: View {
    
    @Binding var showCard: Bool
    @Binding var useAnimation: Bool
    
    var hint : String = ""
    
    
    var body: some View {
        withAnimation(.spring) {
            VStack {
                HStack{
                    
                    Button {
                        useAnimation = false
                        showCard.toggle()
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .foregroundColor(Color(UIColor.label))
                    }
                    Spacer()
                }
                Spacer()
                //Hint definition
                Text("\(hint)")
                Spacer()
            }
            .padding()
            .frame(height: 150)
            .background(RoundedRectangle(cornerRadius: 20).fill(Color(.background)))
            .overlay(content: {
                RoundedRectangle(cornerRadius: 20)
                                 .stroke(Color.textField, lineWidth: 2)
            })
            .padding(.horizontal)
            .offset(x: showCard ? 0 : -400)
        }
        
       
    }
}

#Preview {
    HintCard(showCard: .constant(true), useAnimation: .constant(true))
}
