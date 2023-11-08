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
       withAnimation(.default) {
            VStack {
                HStack{
                    Button {
                        useAnimation = false
                        showCard = false
                      
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
            .frame(height: 160)
            .background(RoundedRectangle(cornerRadius: 18).fill(Color(.background)))
            .overlay(content: {
                RoundedRectangle(cornerRadius: 18)
                                 .stroke(Color.textField, lineWidth: 2)
            })
            .padding(.horizontal)
            .offset(x: showCard ? 0 : -1500)
            //        .animation(useAnimation ? .spring : .none, value: showCard)
       }
        
       
    }
}

#Preview {
    HintCard(showCard: .constant(true), useAnimation: .constant(true))
}
