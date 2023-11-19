//
//  ScoreDeleteView.swift
//  VocBox
//
//  Created by Jessie Pastan on 11/18/23.
//

import SwiftUI

struct ScoreDeleteView: View {
    
    var body: some View {
        
        VStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
                .overlay {
                    GeometryReader { proxy in
                        DeleteScoreCard()
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
    ScoreDeleteView()
}
