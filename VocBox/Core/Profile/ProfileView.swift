//
//  ProfileView.swift
//  VocBox
//
//  Created by Jessie Pastan on 10/4/23.
//

import SwiftUI
import CoreData

struct ProfileView: View {
    
    @AppStorage("isDarkMode") var isDarkMode = false
    
    @Environment(\.managedObjectContext) var moc
    
    @EnvironmentObject var storeViewModel: StoreViewModel
    
    @Environment(\.dismiss) var dismiss
    
    @State private var isShowAlert = false
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) private var scores: FetchedResults<Score>
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.joinedDate)]) private var user: FetchedResults<User>
    
    //@FetchRequest(sortDescriptors: [SortDescriptor(\.reminderTime)]) private var user: FetchedResults<User>
    
    var body: some View {
        
     
        
        VStack(alignment: .leading) {
         
            HStack{
                Image(systemName: "person.circle").resizable().scaledToFill().frame(width: 65, height: 65)
                Text("Joined: \(user[0].viewJoinedDate)")
            }
            .padding(.top,20)
            .padding(.bottom,-20)
            .padding(.horizontal)
            .foregroundColor(Color(UIColor.label))
            
            
            List{
                
                 //MARK: Pro Upgrade
                VStack{
                    if storeViewModel.purchasedSubsriptions.isEmpty {
                        NavigationLink {
                            ProUpgradeView()
                        } label: {
                            Text("Pro Upgrade")
                        }
                       
                    }else {
                        //show that user already subscribed
                        Text("Pro Upgraded")
                        
                    }
                }
                .foregroundColor(Color.text)
                .listRowBackground(Color.card)
                 
                
                //MARK: Statictics navigate bar
                NavigationLink {
                    StatisticView()
                } label: {
                    Text("Statistics")
                }
                .foregroundColor(Color.text)
                .listRowBackground(Color.card)
                
                //MARK: Search Screen
                NavigationLink {
                    SearchView()
                } label: {
                    Text("Search")
                }
                .foregroundColor(Color.text)
                .listRowBackground(Color.card)
                
                //MARK: Widget setting
                NavigationLink {
                    WidgetSettingView()
                } label: {
                    Text("Widget")
                }
                .foregroundColor(Color.text)
                .listRowBackground(Color.card)
                
                //MARK: Reminder
                NavigationLink {
                    ReminderView(user: user[0])
                    
                } label: {
                    Text("Daily reminder")
                }
                .foregroundColor(Color.text)
                .listRowBackground(Color.card)
                
                //MARK: Delete score history
                if !scores.isEmpty {
                    VStack {
                        Button {
                            // show alert
                            isShowAlert = true
                        } label: {
                            HStack{
                                Text("Delete all score records")
                            }
                        }
                        .alert("Are you sure you want to delete all score records?",
                               isPresented: $isShowAlert) {
                            HStack{
                                Button(role: .destructive) {
                                    CoreDataController().deleteScores(scores: scores, context: moc)
                                } label: {
                                    Text("Delete")
                                }
                            }
                        }
                    }
                    .foregroundColor(Color.text)
                    .listRowBackground(Color.card)
                }
                
                
                //MARK: Toggle Dark Mode
                Toggle(isOn: $isDarkMode) {
                    Text("Dark Mode")
                }
                .tint(Color(.button))
                .listRowBackground(Color.card)
            }
            .foregroundColor(Color.text)
            .scrollContentBackground(.hidden)
            .scrollDisabled(true)
            
        }
        .background(Color.background)
        
        
        
    }
}

#Preview {
    ProfileView()
}
