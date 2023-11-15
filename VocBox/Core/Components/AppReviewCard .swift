//
//  AppReviewCard .swift
//  VocBox
//
//  Created by Jessie Pastan on 11/14/23.
//

import SwiftUI

struct AppReviewCard: View {
    @EnvironmentObject var appReviewManager: AppReviewManager
    @Environment(\.openURL) var openURL
   
    
    var body: some View {
        ZStack{
            Rectangle()
            VStack{
                Spacer()
                Image("five-stars")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                Text("We really appreciate your time for our app review!")
                    .bold()
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                //MARK: Navigate back to profile view
            
                Button {
                    
                        if let link = appReviewManager.linkReview {
                         openURL(link)
                            
                        }
    
                }
                label: {
                    GeometryReader { proxy in
                        SmallButton(title: "Write review")
                    }
                    .frame(height: 44)
                    .padding(.horizontal)
                }
                .padding(.bottom,20)
            }
        }
        .foregroundColor(.card)
        .cornerRadius(10)
        
        
        
    }
    
    
}

#Preview {
    AppReviewCard()
}
 

