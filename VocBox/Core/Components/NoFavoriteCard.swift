//
//  NoFavoriteCard.swift
//  VocBox
//
//  Created by Jessie Pastan on 11/6/23.
//

import SwiftUI

struct NoFavoriteCard: View {
    
    var body: some View {
        
        ZStack{
            Rectangle()
            VStack{
                Spacer()
                Image("hearty")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                
                Spacer()
                
                Text("You have no favorites yet.")
                Spacer()
        
            }
            .bold()
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
        }
        .foregroundColor(.card)
        .cornerRadius(10)
    
    }
        
}

#Preview {
    NoFavoriteCard()
}
