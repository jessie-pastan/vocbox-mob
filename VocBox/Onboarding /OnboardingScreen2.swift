//
//  OnboardingScreen2.swift
//  VocBox
//
//  Created by Jessie Pastan on 10/17/23.
//

import SwiftUI

struct OnboardingScreen2: View {
    var body: some View {
        ZStack{
            Color.background
                .ignoresSafeArea()
            VStack(spacing: 50 ){
                VStack{
                    Text("'Recall Challenge'")
                  
                }
                .font(.system(size: 45))
                .bold()
                
                Image("brain")
                    .resizable()
                    .frame(width: 300, height: 300)
                    .scaledToFit()
                VStack{
                    Text("Train your vocabulary memory")
                    Text("and track progress")
                }
                .font(.title2)
                .multilineTextAlignment(.center)
                .frame(width: 200, height: 100)
                GeometryReader { proxy in
                    SmallButton(title: "Get Started")
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
    OnboardingScreen2()
}
