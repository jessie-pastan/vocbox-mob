//
//  ShareAppView.swift
//  VocBox
//
//  Created by Jessie Pastan on 11/16/23.
//

import SwiftUI

struct ShareAppView: View {
    
    let image = Image("shareVocBox1")
    
    var body: some View {
        
        VStack {
            Color(.gray)
                .edgesIgnoringSafeArea(.all)
                .overlay {
                    VStack {
                        image
                            .resizable()
                            .frame(width: 500, height: 500)
                            .scaledToFit()
                        Text("Let them know about our great app!")
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                            .font(.custom(.playfairBold, size: 22))
                            
                      
                       ShareLink(item: image, preview: SharePreview("Check this App out!", image: image))
                        
                        //After get App launch on App Store use URL form app store here 
                        //ShareLink("Share App's URL" , item: URL(string: "vocbox.ituneApp")!, subject: Text("Vocabulary storage app"), message: Text("Check this app out!"))
                    }
                    .background(Color(.gray))
                }
        }
    }
}

#Preview {
    ShareAppView()
}
