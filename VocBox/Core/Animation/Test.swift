//
//  Test.swift
//  VocBox
//
//  Created by Jessie Pastan on 10/7/23.
//

import SwiftUI

struct Test: View {
    @State var text = ""
    let colours = [
        Color.blue,
        Color.green,
        Color.red,
        Color.yellow,
        Color.pink
    ]
    var body: some View {
        NavigationStack {
           
                List {
                    
                    ForEach(0..<20, id: \.self) { index in
                        Text("Item \(index)")
                    }
                    
                }
                //.scrollContentBackground(.hidden)
                .listStyle(GroupedListStyle()) // Optional list style
                .searchable(text: $text, placement: .navigationBarDrawer(displayMode: .always))
           
                .scrollContentBackground(.hidden)
        }
    }
    
}
        
        
        /*
        //GeometryReader { proxy in
        VStack{
            ScrollView {
                VStack{
                    ForEach(0..<colours.count, id: \.self) { index in
                        Section {
                            Text("View \(index)")
                        } header: {
                            HStack{
                                Text("Section \(index)")
                                Spacer()
                            }
                        }
                        .frame(maxWidth: .infinity)
                        //.padding(.horizontal, max(proxy.safeAreaInsets.leading, proxy.safeAreaInsets.trailing))
                        .background(colours[index])
                    }
                }
                
                }
            }
            .background(Color.background)
            .searchable(text: $text)
            //.edgesIgnoringSafeArea(.horizontal)
        //}
    }
         */


#Preview {
    Test()
}
