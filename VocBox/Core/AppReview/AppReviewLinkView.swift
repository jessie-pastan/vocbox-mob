//
//  AppReviewLinkView.swift
//  VocBox
//
//  Created by Jessie Pastan on 11/14/23.
//

import SwiftUI

struct AppReviewLinkView: View {
    
    
    
    var body: some View {
        
        VStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
                .overlay {
                    GeometryReader { proxy in
                        AppReviewCard()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 400)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 70)
                }
           
        }
       
    }
}

#Preview {
    AppReviewLinkView()
}
