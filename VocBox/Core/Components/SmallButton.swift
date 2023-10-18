//
//  SmallButton.swift
//  VocBox
//
//  Created by Jessie P on 9/16/23.
//

import SwiftUI

struct SmallButton: View {
    @Environment(\.colorScheme) var colorScheme
    
    var title = "Title"
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 120)
                .foregroundColor(Color.button)
            Text(title)
                .font(.caption)
                .bold()
                .foregroundColor(Color.text)
        }
        .background(Rectangle().foregroundColor(.textField).cornerRadius(120).offset(x: 2, y: 2))
        .padding(.top, 5)
        .padding(.leading, -5)
        
        
    }
}

struct SmallButton_Previews: PreviewProvider {
    static var previews: some View {
        SmallButton()
    }
}
