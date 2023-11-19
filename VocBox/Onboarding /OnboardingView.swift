//
//  OnboardingView.swift
//  VocBox
//
//  Created by Jessie Pastan on 10/18/23.
//

import SwiftUI

struct OnboardingView: View {

    var page: OnboardingPage
    @State private var opacity = 0.0
    var width: CGFloat = 0
    var height: CGFloat = 0
    
    var body: some View {
       
            VStack {
                Spacer()
                VStack {
                    Text(page.title)
                        //.padding(.top, 15)
                        .font(.custom(.abrilFatfaceRegular, size: 44))
                        .lineLimit(2, reservesSpace: true)
                        .multilineTextAlignment(.center)
                }
                .font(.system(size: 45))
                .bold()
                Spacer()
                
                VStack{
                    VStack{
                        LottieView(name: page.imageUrl)
                            .frame(width: width , height: height)
                    }
                    .offset(y: 60)
                    
                    Text(page.description1)
                    Text(page.description2)
                }
                .font(.custom(.playfairDisplayRegular, size:20))
                .padding(.top, -70)
                
                Spacer()
            }
            .opacity(opacity)
            .onAppear{
                withAnimation(.easeInOut(duration: 1.4)) {
                    self.opacity = 1.0 
                }
            }
    }
}

#Preview {
    OnboardingView(page: OnboardingPage.samplePage)
}
