//
//  ProfileView.swift
//  VocBox
//
//  Created by Jessie Pastan on 10/4/23.
//

import SwiftUI

struct ProfileView: View {
    
   @AppStorage("isDarkMode") var isDarkMode = false
   

    var body: some View {
        
        VStack(alignment: .leading) {
            HStack{
               
                Image(systemName: "person.circle").resizable().scaledToFill().frame(width: 65, height: 65)
                Text("Joined March2023")
            }
            .padding(.top,20)
            .padding(.bottom,-20)
            .padding(.horizontal)
           
            .foregroundColor(Color(UIColor.label))
            
            List{
                //MARK: Pro Upgrade
                NavigationLink {
                    ProUpgradeView()
                } label: {
                    Text("Pro Upgrade")
                }
                .foregroundColor(Color.text)
                .listRowBackground(Color.card)
                                
                //MARK: Statictics navigate bar
                NavigationLink {
                    StatisticsView()
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
                    ReminderView()
                } label: {
                    Text("Reminder")
                }
                .foregroundColor(Color.text)
                .listRowBackground(Color.card)
                
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