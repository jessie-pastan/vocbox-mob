//
//  Animation.swift
//  VocBox
//
//  Created by Jessie Pastan on 9/23/23.
//

import SwiftUI

struct Animation: View {
    @State private var change = false
    
    var body: some View {
        VStack{
           
            Spacer()
            Circle()
                .frame(width: 100, height: 100)
                .foregroundColor(.red)
                .offset(x: change ? -140 : 140, y: change ? -650 : 0 )
                .animation(.linear,value: change)
                
            
            Button("Press") {
                change.toggle()
            }
        }
    }
}

struct Animation_Previews: PreviewProvider {
    static var previews: some View {
        Animation()
    }
}
