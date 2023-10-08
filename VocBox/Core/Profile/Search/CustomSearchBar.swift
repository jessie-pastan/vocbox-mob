//
//  CustomSearchBar.swift
//  VocBox
//
//  Created by Jessie Pastan on 10/7/23.
//

import SwiftUI

struct CustomSearchBar: View {
    @Binding var text: String
    @State private var isEditing = false
    
    var body: some View {
        HStack{
            TextField("Search", text: $text)
                .padding()
                .padding(.horizontal)
                .background(Color.gray.opacity(0.15))
                .frame(height: 35)
                .cornerRadius(8)
                .overlay(content: {
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment : .leading)
                            .padding(.leading, 8)
                        
                        if isEditing {
                            Button(action: {
                               
                                self.text = ""
                            }, label: {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            })
                        }
                    }
                })
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
            
            if isEditing {
                withAnimation {
                    Button(action: {
                        self.isEditing = false
                        self.text = ""
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }, label: {
                        Text("Cancel")
                    })
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                }
            }
        }
    }
}

#Preview {
    CustomSearchBar(text: .constant(""))
}
