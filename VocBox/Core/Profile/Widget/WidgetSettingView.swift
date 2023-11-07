//
//  WidgetSettingView.swift
//  VocBox
//
//  Created by Jessie Pastan on 10/3/23.
//

import SwiftUI

struct WidgetSettingView: View {
    var body: some View {
        VStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
                .overlay {
                    GeometryReader { proxy in
                        WidgetCard()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 500)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 70)
                }
           
        }
    }
}

#Preview {
    WidgetSettingView()
}
