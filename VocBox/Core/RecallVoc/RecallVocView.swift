//
//  RecallVocView.swift
//  VocBox
//
//  Created by Jessie P on 9/14/23.
//

import SwiftUI
//import CoreData
import ConfettiSwiftUI

struct RecallVocView: View {
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.createDate, order: .reverse)]) private var vocabs: FetchedResults<Vocab>
    @Environment(\.managedObjectContext) var moc

    @ObservedObject var vm = RecallVocViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    @State private var text = ""
    @State private var currentScore = 0
    @State private var arrayOfRecalledVocab = [String]()

    @State private var isSubmitted = false
    
    @State private var feedback = ""
    @State var progress: CGFloat = 0.0
    private var compliments = ["Good job!", "Keep Going.", "You Rock!"]
    
    @State private var counter = 0
    @State private var showAlert1 = false
    @State private var showAlert2 = false
    @State private var scorePercentage = ""
    
    //need hint in @State not in vm
    @State private var hint = ""
    @State private var showCard = false
    @State private var useAnimation = false
    
    var body: some View {
        let trimmedText = TrimString.trimString(input: text)

        GeometryReader { proxy in
            VStack(alignment: .leading) {
                //MARK: Wording
                VStack(alignment: .leading){
                    Text("Improve your memory")
                    Text("by recalling \(vocabs.count)")
                    Text("stored words!")
                }
                .font(.title)
                
                Text("Try to recall vocab as much as you can")
                Spacer()
                
                //MARK: Progress bar
                VStack{
                    //MARK: Confetti
                    HStack{
                        Text("")
                        ConfettiCannon(counter: $counter)
                    }
                    GeometryReader { proxy in
                        RecallProgressView(width: proxy.size.width, progress: progress)
                    }
                }
                .padding()
                
                
                //MARK: Current Score
                VStack(alignment: .center){
                    HStack{
                        Text("Current Score")
                        Text(" \(currentScore)/\(vocabs.count)")
                    }
                    //MARK: feedback
                    Text("\(feedback)")
                    
                }.frame(maxWidth: .infinity)
                
                Spacer()
                TextField("Type a word you can remember!", text: $text)
                    .padding(10)
                    .frame(width: proxy.size.width / 1.08, height: 33)
                    .background(Color.textField)
                    .cornerRadius(10)
                    .disableAutocorrection(true)
                   
                
                
                
                //MARK: Recall button
                Button {
                   
                    //action: verify whether this vocab exist in VocBox and update score
                    // convert fetchedResult to array of Vocab object in order to loop through
                    let arrayOfVocab = arrayOfVocab()
                    print("DEBUG: all vocab = \(arrayOfVocab.count)")
                    print(arrayOfVocab)
                    
                    
                    if arrayOfRecalledVocab.contains(trimmedText) {
                        currentScore = currentScore
                        print("You have recalled this word!")
                        feedback = "You have recalled '\(trimmedText)'."
                        
                    }
                    //MARK: if user recall word successfully
                    else if  vm.vocabExistInCoreData(text: trimmedText, vocabs: arrayOfVocab) {
                        currentScore += 1
                        
                        //MARK: update recall amount if that Vocab
                        CoreDataController().updateVocabRecall(vocabs: vocabs, successfullRecalledVocab: trimmedText, context: moc)
                        
                        //MARK: verify if user already recalled this word
                        arrayOfRecalledVocab.append(trimmedText)
                        //MARK: Also add definition in array
                       // arrayOfRecalledDefinition.append()
                        
                        if let feedbackWord = compliments.randomElement() {
                            feedback = "We found '\(trimmedText)'. \(String(describing: feedbackWord))"
                        }
                            
                        print("We found word. Good job!")
                        print(arrayOfRecalledVocab)
                        //MARK: Update progress bar
                        let increasedBy = vm.calculateProgressPercent(vocabs: arrayOfVocab)
                        self.progress += increasedBy
                        //MARK: Trigger Confetti
                        if progress > 99 {
                            counter += 1
                            //MARK: Trigger Alert
                            showAlert1 = true
                            //MARK: Save user score in coreData
                            CoreDataController().addUserScore(allVocabAmount: arrayOfVocab.count, userScore: currentScore, context: moc)
                        }
                        print(progress)
                        print(increasedBy)
                        
                        
                    }else{
                        feedback = "Opps! Try again"
                        print("Opps! Try again")
                    }
                    
                    //MARK: Free text field after submit
                    text = ""
                } label: {
                    Text("Submit")
                        .font(.body)
                        .lineLimit(1)
                        .frame(width: proxy.size.width / 1.10, height: 23)
                        .foregroundColor(Color.text)
                        .padding(7)
                        .background(Color.button)
                        .cornerRadius(120)
                }
                .background(Rectangle().foregroundColor(.textField).cornerRadius(120).offset(x: 2, y: 2))
                .padding(.top, 5)
                .padding(.leading, -5)
                
                
            }
            //MARK: Alert for 100% Score
            .alert("Congratulations.",
                   isPresented: $showAlert1) {
                   Button("Ok") {
                        dismiss()
                   }
            } message: {
                   Text("Fantastic! You got 100% score.")
            }
            .fontWeight(.bold)
            .padding()
            
            //MARK: Done tool bar
            .toolbar {
                Button {
                    
                    //MARK: Calculate user score and save in coredata
                    let arrayOfVocab = arrayOfVocab()
                    CoreDataController().addUserScore(allVocabAmount: arrayOfVocab.count, userScore: currentScore, context: moc)
                    //calculate % for displaying in UI
                    scorePercentage = vm.userScorePercentage(vocabs: arrayOfVocab, userScore: currentScore)
                    
                    //MARK: Trigger Alert
                    showAlert2 = true
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 120)
                            .frame(height: 20)
                            .foregroundColor(Color.button)
                        Text("Quit")
                            .padding()
                            //.font(.custom(.playfairBold, size: 17))
                            .bold()
                            .foregroundColor(Color.text)
                    }
                    .background(Rectangle().frame(height: 20).foregroundColor(.textField).cornerRadius(120).offset(x: 2, y: 2))
                    .padding(.top, 5)
                    .padding(.leading, -5)
                    .alert("Wonderful.",
                           isPresented: $showAlert2) {
                           Button("Ok") {
                                dismiss()
                           }
                    } message: {
                           Text("You got \(scorePercentage)% score. Keep it up:)")
                    }
                    
                }
                
               
            }
            
        
            //MARK: Hint tool bar
            .toolbar {
                Button {
                    //show a hint on UI
                    hint = vm.randomHint(vocabs: vocabs, arrayOfRecalledVocabs: arrayOfRecalledVocab)
                    showCard = true
                    useAnimation = true
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 120)
                            .frame(height: 20)
                            .foregroundColor(Color.button)
                        Text("Hint!")
                            //.font(.custom(.playfairBold, size: 17))
                            .padding()
                            .bold()
                            .foregroundColor(Color.text)
                    }
                    .background(Rectangle().frame(height: 20).foregroundColor(.textField).cornerRadius(120).offset(x: 2, y: 2))
                    .padding(.top, 5)
                    .padding(.leading, -5)

                }
            }
            
            //MARK: HintCard with Animation 
            HintCard(showCard: $showCard, useAnimation: $useAnimation, hint: hint)
                .padding(.top, 15)
        }
        .padding(.top, -20)
        .background(Color.background)
        
    }
    
    //MARK: Convert fetchedResult to Array of Vocab
    func arrayOfVocab() -> [Vocab]{
        let vocabFetch = Vocab.fetchRequest()
        vocabFetch.sortDescriptors = [NSSortDescriptor(key: "createDate", ascending: false)]
        let results = (try? self.moc.fetch(vocabFetch) as [Vocab]) ?? []
        return results
    }
    
}


struct RecallVocView_Previews: PreviewProvider {
    static var previews: some View {
        RecallVocView()
    }
}
