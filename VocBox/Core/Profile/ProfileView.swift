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
    @Environment(\.openURL) var openURL
    
    @State private var isShowAlert = false
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) private var scores: FetchedResults<Score>
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.joinedDate)]) private var user: FetchedResults<User>
    
    //@FetchRequest(sortDescriptors: [SortDescriptor(\.reminderTime)]) private var user: FetchedResults<User>
    
    var body: some View {
        
     
        
        VStack(alignment: .leading) {
         
            HStack{
                Image(systemName: "person.circle").resizable().scaledToFill().frame(width: 50, height: 50)
                Text("Joined \(user[0].viewJoinedDate)")
            }
            .font(.custom(.playfairBold, size: 17))
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
                        .id(UUID())
                       
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
                .id(UUID())
                .foregroundColor(Color.text)
                .listRowBackground(Color.card)
                
                
                //MARK: Search Screen
                NavigationLink {
                    SearchView()
                } label: {
                    Text("Search")
                }
                .id(UUID())
                .foregroundColor(Color.text)
                .listRowBackground(Color.card)
                
                //MARK: Widget setting
                NavigationLink {
                    WidgetSettingView()
                } label: {
                    Text("Widget")
                }
                .id(UUID())
                .foregroundColor(Color.text)
                .listRowBackground(Color.card)
                
                //MARK: Reminder
                NavigationLink {
                    ReminderView(user: user[0])
                    
                } label: {
                    Text("Daily reminder")
                }
                .id(UUID())
                .foregroundColor(Color.text)
                .listRowBackground(Color.card)
                
                
                //MARK: Review
                 //got freeze when app not available in app store ??
                VStack {
                    
                    NavigationLink {
                        AppReviewLinkView()
                    } label: {
                        Text("Leave a review")
                    }
                }
                .id(UUID())
                .foregroundColor(Color.text)
                .listRowBackground(Color.card)

                //MARK: Privacy policy
                VStack {
                    Button {
                        //open link url
                        if let link  =  AppConstants.privacyPolicyLink {
                            openURL(link)
                        }
                    } label: {
                        Text("Privacy policy")
                    }
                }
                .id(UUID())
                .foregroundColor(Color.text)
                .listRowBackground(Color.card)
                
                //MARK: Terms of use
                VStack {
                    Button {
                        //open link url
                        if let link  =  AppConstants.termsOfUseLink {
                            openURL(link)
                        }
                    } label: {
                        Text("Terms of use")
                    }
                }
                .id(UUID())
                .foregroundColor(Color.text)
                .listRowBackground(Color.card)
                
                //MARK: Send Email to support
                VStack{
                    Button(action: {
                       EmailController.shared.sendEmail(subject: "", body: "", to: "vocbox.contact@gmail.com")
                     }) {
                         Text("Contact us")
                     }
                }
                .id(UUID())
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
