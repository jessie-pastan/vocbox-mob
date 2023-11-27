//
//  DeleteScoreCard.swift
//  VocBox
//
//  Created by Jessie Pastan on 11/18/23.
//

import SwiftUI

struct DeleteScoreCard: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var animationTrigger = false
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) private var scores: FetchedResults<Score>
    
    
    var body: some View {
        
        ZStack{
            Rectangle()
            VStack{
                Text("All score got deleted!")
                    .padding()
                    .bold()
                    .foregroundStyle(.red)
                    .opacity(animationTrigger ? 1 : 0)
                    .animation(.easeInOut(duration: 1.0), value: animationTrigger)
                Spacer()
                Text("Are you sure you want to delete all score records?")
                    .font(.custom(.playfairBold, size: 22))
                    .padding(.horizontal)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                
                Spacer()
                //MARK:Buttons
        
                HStack {
                    Spacer()
                    Button {
                        //dismiss
                        dismiss()
                    } label: {
                        GeometryReader { proxy in
                            
                            ZStack{
                                RoundedRectangle(cornerRadius: 120)
                                    .foregroundColor(Color.button)
                                
                                Text("Cancel")
                                    .font(.body)
                                    .bold()
                                    .foregroundColor(Color.text)
                                
                            }
                            .background(Rectangle().foregroundColor(.textField).cornerRadius(120).offset(x: 2, y: 2))
                            .padding(.top, 5)
                            .padding(.leading, -5)
                            .padding(.horizontal)
                            
                        }
                        .frame(height: 44)
                    }
                    
                    Spacer()
                    
                    Button {
                        //action: delete score
                        CoreDataController().deleteScores(scores: scores, context: moc)
                        UserDefaults.standard.removeObject(forKey: AppConstants.totalChallengeScore)
                        
                        withAnimation(Animation.linear.delay(0.7)){
                            self.animationTrigger = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            dismiss()
                        }
                    } label: {
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 120)
                                .foregroundColor(Color.button)
                            
                            HStack{
                               
                                Image(systemName: "trash")
                                    .foregroundStyle(.red)
                                   
                                Text("Delete")
                                    .font(.body)
                                    .bold()
                                    .foregroundColor(Color.text)
                                 
                                
                            }
                            
                            
                        }
                        .background(Rectangle().foregroundColor(.textField).cornerRadius(120).offset(x: 2, y: 2))
                        .padding(.top, 5)
                        .padding(.leading, -5)
                        .padding(.horizontal)
                        
                        
                    }
                   
                    .frame(height: 44)
            
                }
                .padding()
                .padding(.horizontal)
            }
            
        } 
        .foregroundColor(.card)
        .cornerRadius(10)
    }
}

#Preview {
    DeleteScoreCard()
}
