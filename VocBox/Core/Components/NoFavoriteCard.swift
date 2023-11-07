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
                Image(systemName: "heart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
              
                Text("Tap on heart")
                Text("To mark your favorite vocabulary")
                  
                
                Spacer()
                
                //MARK: Navigate back to profile view
            
                Button {
                  
                }
                label: {
                    GeometryReader { proxy in
                        SmallButton(title: "Got it")
                    }
                    .frame(height: 44)
                    .padding(.horizontal)
                }
                .padding(.bottom,20)
            }
            .bold()
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
        }
        .foregroundColor(.white)
        .cornerRadius(10)
        
        
        
       
    }
        
}

#Preview {
    NoFavoriteCard()
}
