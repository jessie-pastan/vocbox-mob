//
//  ProfileView.swift
//  VocBox
//
//  Created by Jessie Pastan on 10/4/23.
//

import SwiftUI
import CoreData
import StoreKit

struct ProfileView: View {
    
    @AppStorage("isDarkMode") var isDarkMode = false
    
    @Environment(\.managedObjectContext) var moc
    
    @EnvironmentObject var storeViewModel: StoreViewModel
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.openURL) var openURL
    
    @State private var isShowAlert = false
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) private var scores: FetchedResults<Score>

    @FetchRequest(sortDescriptors: [SortDescriptor(\.joinedDate)]) private var user: FetchedResults<User>
    

    var body: some View {
        
     
        
        VStack(alignment: .leading) {
         
            HStack{
                Image(systemName: "person.circle").resizable().scaledToFill().frame(width: 50      , height: 50)
                Text("Joined \(user[0].viewJoinedDate)")
            }
            .font(.custom(.playfairBold, size: 22))
            .padding(.top,20)
            .padding(.bottom,-20)
            .padding(.horizontal)
            .foregroundColor(Color(UIColor.label))
            
           
                List{
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
                        Text("Daily Reminder")
                    }
                    .foregroundColor(Color.text)
                    .listRowBackground(Color.card)
                    
                    
                    //MARK: Review
                    VStack {
                        
                        NavigationLink {
                            AppReviewLinkView()
                        } label: {
                            Text("Leave Review")
                        }
                    }
                    .foregroundColor(Color.text)
                    .listRowBackground(Color.card)
                    
                    //MARK: Share app to a friend
                    VStack {
                        NavigationLink {
                            ShareAppView()
                        }label: {
                            Text("Share App")
                        }
                    }
                    .foregroundColor(Color.text)
                    .listRowBackground(Color.card)
                    
                    
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
                    
                    
                    
                    //MARK: Delete score history
                    if !scores.isEmpty {
                        VStack {
                            NavigationLink {
                                ScoreDeleteView()
                                
                            } label: {
                                HStack{
                                    Text("Delete all score records")
                                }
                            }
                            
                        }
                        .foregroundColor(Color.text)
                        .listRowBackground(Color.card)
                    }
                    
                    //MARK: Privacy policy
                    VStack {
                        Button {
                            CrashManager.shared.addLog(message: "tapped on privacy policy button")
                            //open link url
                            if let link  =  AppConstants.privacyPolicyLink {
                                openURL(link)
                            }
                        } label: {
                            Text("Privacy Policy")
                        }
                    }
                    
                    .foregroundColor(Color.text)
                    .listRowBackground(Color.card)
                    
                    //MARK: Terms of use
                    VStack {
                        Button {
                            CrashManager.shared.addLog(message: "tapped on term of use button")
                            //open link url
                            if let link  =  AppConstants.termsOfUseLink {
                                openURL(link)
                            }
                        } label: {
                            Text("Terms of Use")
                        }
                    }
                    
                    .foregroundColor(Color.text)
                    .listRowBackground(Color.card)
                    
                    //MARK: Send Email to support
                    VStack{
                        Button(action: {
                            CrashManager.shared.addLog(message: "tapped on contact us button")
                            EmailController.shared.sendEmail(subject: "", body: "", to: "vocbox.contact@gmail.com")
                        }) {
                            Text("Contact us")
                        }
                    }
                    
                    .foregroundColor(Color.text)
                    .listRowBackground(Color.card)
                    
                    
                    
                    
                    
                    //MARK: Toggle Dark Mode
                    Toggle(isOn: $isDarkMode) {
                        Text("Dark Mode")
                    }
                    .onTapGesture {
                        CrashManager.shared.addLog(message: "toggled darkmode")
                    }
                    .tint(Color(.button))
                    .listRowBackground(Color.card)
                }
                //need below id(UUID()) to prevent Nav links freeze
                .id(UUID())
                .foregroundColor(Color.text)
                .scrollContentBackground(.hidden)
                
        
            
        }
        .onAppear(perform: {
            CrashManager.shared.addLog(message: "profile view appeared on user's screen")
        })
        .background(Color.background)
        
        
        
    }
}

#Preview {
    ProfileView()
}
