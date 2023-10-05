//
//  RecallProgressView.swift
//  VocBox
//
//  Created by Jessie P on 9/21/23.
//

import SwiftUI

struct RecallProgressView: View {
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.createDate, order: .reverse)]) private var vocabs: FetchedResults<Vocab>
    //var progressValue: Float
    
    var width: CGFloat = 0
    var height: CGFloat = 20
    var progress: CGFloat = 0
   
    var body: some View {
        
        let multiplier = width / 100
        ZStack(alignment: .leading) {
            ZStack{
            
                Capsule().fill(Color.gray)
                    .frame(height: height)
            }
            Capsule()
                .fill(LinearGradient(gradient: .init(colors: [Color.card , Color.card]), startPoint: .leading, endPoint: .trailing))
                .frame(width: progress * multiplier, height: height)
        }
        
    }
}

struct RecallProgressView_Previews: PreviewProvider {
    static var previews: some View {
        RecallProgressView()
    }
}
