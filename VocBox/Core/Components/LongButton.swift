//
//  LongButton.swift
//  VocBox
//
//  Created by Jessie Pastan on 10/24/23.
//

import SwiftUI

struct LongButton: View {
    
    var title: String = ""
    var width: CGFloat = 120
    var height: CGFloat = 35
    
    var body: some View {      
        VStack{
            Text(title)
                .lineLimit(1)
                .frame(width: width , height: height)
                .foregroundColor(Color.text)
                .padding(7)
                .background(Color.button)
                .cornerRadius(120)
        }
        .background(Rectangle().foregroundColor(.textField).cornerRadius(120).offset(x: 2, y: 2))
        .padding(.top, 5)
        .padding(.leading, -5)
    
    
        }
    }


/*
#Preview {
    LongButton()
}
*/
