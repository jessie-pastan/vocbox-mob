//
//  CreateFirstVocabCard.swift
//  VocBox
//
//  Created by Jessie Pastan on 9/22/23.
//

import SwiftUI

struct CreateFirstVocabCard: View {
    var body: some View {  
        
        ZStack{
            
            Rectangle()
            VStack{
                Spacer()
                Image("open-box")
                    .resizable().aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                    
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
                Button {
                    //dismiss card
                } label: {
                    Text("Got it")
                        .foregroundColor(.white)
                }
                .background(Color(.black))
                .buttonStyle(.bordered)
                .cornerRadius(20)
                .padding(.bottom)
                
               
                    /*
                    VStack(spacing: 30){
                        HStack{
                            Text("It's")
                            Text("time")
                        }
                        HStack{
                            Text("To")
                            Text("Add")
                            Text("Your")
                        }
                        Text("first")
                        Text("Voc")
                        Text("in")
                        Text("the")
                        Text("Box")
                    }
                    .font(.title3)
                    .bold()
                    .foregroundColor(.text)
                     */
                
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
