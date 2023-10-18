//
//  SplashScreenView.swift
//  VocBox
//
//  Created by Jessie Pastan on 10/17/23.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var imageSize = 0.8
    @State private var textSize = 0.8
    @State private var opacity = 0.3
    @State private var isMove = false
    @State private var animationStep = 0
    
    var body: some View {
        if isActive {
            ReviewVocView()
        }else {
            
            ZStack{
                Color.background
                    .ignoresSafeArea()
                VStack{
                    Image("open-box")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .scaleEffect(imageSize)
                        .offset(x: isMove ? 0 : 0, y: isMove ? 0 : -420)
                        
                    Text("VocBox").bold()
                        .padding(.top, 3)
                        .scaleEffect(textSize)
                    
                }
                .opacity(opacity)
                .onAppear {
                    withAnimation(.bouncy(duration: 1.4)) {
                            self.imageSize = 1.2
                            self.textSize = 2.0
                            self.opacity = 1.0
                            isMove = true
                        }
                    }
            }.onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3 ){
                    self.isActive = true
                }
            }
        }
    }
}
#Preview {
    SplashScreenView()
}
 
