//
//  VocBoxApp.swift
//  VocBox
//
//  Created by Jessie P on 9/14/23.
//

import SwiftUI
import FirebaseCore

  
@main
  struct VocBoxApp: App {
      
      init() {
          FirebaseApp.configure()
          print("Configured Firebase!")
      }
  
    var body: some Scene {
        WindowGroup {
            
           //this code is for testing splash screen and on boarding screens
           /*
            SplashScreenView()
                .modifier(DarkModeViewModifier())
                .environment(\.managedObjectContext,CoreDataController().container.viewContext)
                .environmentObject(LocalNotificationManager())
                .environmentObject(StoreViewModel())
                .environmentObject(AppReviewManager())
        */
        
            if UserDefaults.standard.bool(forKey: AppConstants.hasVisitedAppKey) {
                ReviewVocView()
                    .modifier(DarkModeViewModifier())
                    .environment(\.managedObjectContext,CoreDataController().container.viewContext)
                    .environmentObject(LocalNotificationManager())
                    .environmentObject(StoreViewModel())
                    .environmentObject(AppReviewManager())
            }else {
                SplashScreenView()
                    .modifier(DarkModeViewModifier())
                    .environment(\.managedObjectContext,CoreDataController().container.viewContext)
                    .environmentObject(LocalNotificationManager())
                    .environmentObject(StoreViewModel())
                    .environmentObject(AppReviewManager())
                    .onAppear{
                        UserDefaults.standard.set(true, forKey: AppConstants.hasVisitedAppKey)
                    }
            }
          
             
        }
    }
}
