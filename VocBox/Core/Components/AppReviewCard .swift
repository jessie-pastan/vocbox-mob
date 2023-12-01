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
                    .frame(width: 150, height: 150)
                Text("We really appreciate you taking the time to review our app!")
                    .font(.custom(.playfairBold, size: 22))
                    .padding(.horizontal)
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
 

