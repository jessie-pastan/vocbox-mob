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
                        VStack{
                            Spacer()
                            WidgetCard()
                              .position(x: proxy.size.width / 2, y: proxy.size.height / 2 )
                            Spacer()
                        }
                    }
                    
                    .frame(height: 500)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 50)
                }
           
        }
    }
}

#Preview {
    WidgetSettingView()
}
