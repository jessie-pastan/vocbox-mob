//
//  AnalyticView.swift
//  VocBox
//
//  Created by Jessie P on 9/14/23.
//

import SwiftUI

struct AnalyticView: View {
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.createDate, order: .reverse)]) private var vocabs: FetchedResults<Vocab>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) private var Scores: FetchedResults<Score>
    
    
    
    var body: some View {
        
        VStack{
            //1. Card of Hightest score, Lasted score, and Total score
            //need scores in func to loop through
            
            
            Text(   "")
            //2. Card of most recalled vocab
            
            //3. Card of least recalled vocab
        }
    }
    
    
    
    
}

/*
 struct AnalyticView_Previews: PreviewProvider {
 static var previews: some View {
 AnalyticView()
 }
 }
 */
