//
//  SettingView.swift
//  VocBox
//
//  Created by Jessie P on 9/21/23.
//

import SwiftUI

struct SettingView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.createDate, order: .reverse)]) private var vocabs: FetchedResults<Vocab>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) private var Scores: FetchedResults<Score>
    
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        ForEach(vocabs) { item in
            VStack{
                Text("Vocab")
                HStack{
                    Text(item.viewVocab)
                    Text(String(item.viewRecall))
                }
               
            }
        }
        
        
        ForEach(Scores) { item in
            VStack{
                Text("Challenge Scores")
                HStack{
                    
                    Text(String(item.percentage))
                    
                }
            }
        }
        
        
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
