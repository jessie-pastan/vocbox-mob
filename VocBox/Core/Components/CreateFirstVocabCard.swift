//
//  CreateFirstVocabCard.swift
//  VocBox
//
//  Created by Jessie Pastan on 9/22/23.
//

import SwiftUI

struct CreateFirstVocabCard: View {
    
    @State private var isBounce = true
    
    var body: some View {
        
        ZStack{
            
            Rectangle()
            VStack{
                Spacer()
                /*
                Image("open-box")
                    .resizable().aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                 */
                VStack{
                    Text("It's time to add your First Voc in the Box!")
                }
                .padding(.top, 20)
                .padding(.horizontal)
                .font(.title3)
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
                        SmallButton(title: "Add Vocabulary")
                    }
                    .frame(height: 44)
                    .padding(.horizontal)
                }
                .padding(.bottom, 20)
                //MARK: Button Animation
                .offset(y: isBounce ? 1  : -1 )
                .animation(.spring(response: 1.3, dampingFraction: 0), value: isBounce)
                .onAppear{
                    isBounce.toggle()
                }
                
                }
            

        }
        //.frame(width: 300, height: 500 )
        .foregroundColor(.white)
        .cornerRadius(15)
        
    }
}

struct CreateFirstVocabCard_Previews: PreviewProvider {
    static var previews: some View {
        CreateFirstVocabCard()
            .background(.background)
    }
}
