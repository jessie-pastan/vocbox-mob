//
//  TakeAChallengeCard .swift
//  VocBox
//
//  Created by Jessie Pastan on 10/8/23.
//

import SwiftUI

struct TakeAchallengeCard: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        
        ZStack{
            Rectangle()
            VStack{
                Spacer()
                Image("brain")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                Text("Take a Voc recall to see your improvement!")
                    .bold()
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                //MARK: Navigate to recallView
                
                
                Button {
                    dismiss()
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
        }
        .foregroundColor(.white)
        .cornerRadius(10)
        
        
        
       
    }
    
    
}
