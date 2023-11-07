//
//  CreateFirstVocabCard.swift
//  VocBox
//
//  Created by Jessie Pastan on 9/22/23.
//

import SwiftUI

struct CreateFirstVocabCard: View {
    
    @State private var isBounce = true
    let parentHeight: CGFloat
    @State private var yOffset: CGFloat = -2
    
    var body: some View {
        //NavigationStack {
            ZStack{
                
                Rectangle()
                VStack{
                    Spacer()
                    
                    Image("open-box")
                        .resizable().aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200)
                        .offset(y: yOffset)
                        //.animation(.spring(response: 1.3, dampingFraction: 0), value: isBounce)
                        .onAppear{
                            withAnimation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
                                yOffset = parentHeight / 15
                                // Start at the center
                                // isBounce.toggle()
                            }
                        }
                    //.padding(.top, 20)
                    
                    VStack{
                        Text("Hey! It's time to add your Voc in the box!")
                    }
                    .padding(.top, 20)
                    .padding(.horizontal)
                    .font(.custom(.playfairBold, size: 25))
                    .bold()
                    .foregroundColor(.text)
                    .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    //MARK: Got it Button'
                    
                    NavigationLink {
                        //dismiss card or link to add voc card
                        AddVocView()
                    } label: {
                        GeometryReader { proxy in
                            CardButton(title: "Add Vocabulary")
                        }
                        
                        .frame(height: 44)
                        .padding(.horizontal)
                    }
                    
                    .padding(.bottom, 20)
                    .accentColor(.black)
                    
                    
                }
                
                
            }
            //.frame(width: 300, height: 500 )
            .foregroundColor(Color(.card))
            .cornerRadius(15)
        /*
            //MARK: Button Animation
            //.offset(y: isBounce ? 1.5 : -1 )
            .offset(y: yOffset)
            //.animation(.spring(response: 1.3, dampingFraction: 0), value: isBounce)
            .onAppear{
                withAnimation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
                    yOffset = parentHeight / 15
                    // Start at the center
                    // isBounce.toggle()
                }
         
            }
         */
        
        //}.tint(Color(UIColor.label))
    }
}

struct CreateFirstVocabCard_Previews: PreviewProvider {
    static var previews: some View {
        CreateFirstVocabCard(parentHeight: 400)
            .background(.background)
    }
}
