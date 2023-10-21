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
    
    var body: some View {
       
            VStack {
                Spacer()
                VStack {
                    Text(page.title)
                        .font(.custom(.abrilFatfaceRegular, size: 44))
                        .lineLimit(2, reservesSpace: true)
                        .multilineTextAlignment(.center)
                }
                .font(.system(size: 45))
                .bold()
                
                Image("\(page.imageUrl)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .padding()
                
                VStack{
                    Text(page.description1)
                    Text(page.description2)
                }
                .font(.custom(.playfairDisplayRegular, size:20))
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
