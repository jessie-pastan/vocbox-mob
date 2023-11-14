//
//  SubScriptionButton.swift
//  VocBox
//
//  Created by Jessie Pastan on 11/14/23.
//

import SwiftUI

struct SubScriptionButton: View {
   
        var title = ""
        var subtitle = ""
        var body: some View {
            
            ZStack{
                RoundedRectangle(cornerRadius: 120)
                    .foregroundColor(Color.button)
                VStack {
                    Text(title)
                        .font(.custom(.playfairSemibold, size: 17))
                        .font(.body)
                        .bold()
                        
                    Text(subtitle)
                        .font(.footnote)
                        
                }
                .foregroundColor(Color.text)
            }
            .background(Rectangle().foregroundColor(.textField).cornerRadius(120).offset(x: 2, y: 2))
            .padding(.top, 5)
            .padding(.leading, -5)
        }
    }


#Preview {
    SubScriptionButton()
}
