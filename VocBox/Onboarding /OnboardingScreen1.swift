//
//  OnboardingScreen1.swift
//  VocBox
//
//  Created by Jessie Pastan on 10/17/23.
//

import SwiftUI

struct OnboardingScreen1: View {
    var body: some View {
        ZStack{
            Color.background
                .ignoresSafeArea()
            VStack{
                VStack{
                    Text("Welcome to")
                    Text("VocBox!")
                }
                .font(.system(size: 45))
                .bold()
                
                Image("box")
                    .resizable()
                    .frame(width: 400, height: 400)
                    .scaledToFit()
                VStack{
                    Text("Effortlessly store")
                    Text("personal Vocabulary")
                }
                .font(.title2)
                .multilineTextAlignment(.center)
                .frame(width: 200, height: 100)
                GeometryReader { proxy in
                    SmallButton(title: "Next")
                }
                .frame(width: .infinity)
                .frame(height: 59)
                .padding()
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    OnboardingScreen1()
}
