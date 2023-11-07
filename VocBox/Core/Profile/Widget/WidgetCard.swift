//
//  WidgetCard.swift
//  VocBox
//
//  Created by Jessie Pastan on 11/2/23.
//

import SwiftUI

struct WidgetCard: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        
        ZStack{
            Rectangle()
            VStack{
                Spacer()
                Image("widget")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding(.bottom,20)
                VStack{
                    Text("Now you can add VocBox widget to home screen!")
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 10)
                 
                        Text("Follow steps:")
                    VStack(alignment: .leading) {
                        Text("1. On home screen, touch and hold an empty space")
                           
                        Text("2. Tap plus sign on upper left corner")
                        Text("3. On search widgets bar type 'VocBox'")
                            //.fixedSize(horizontal: false, vertical: true)
                        Text("4. Tap on VocBox app name")
                        Text("5. Tap on 'Add Widget'")
                    }
                    .padding(.bottom)
                }
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(.black)
                .padding(.horizontal)
                
                Spacer()
                
                //MARK: Navigate back to profile view
            
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

#Preview {
    WidgetCard()
}
