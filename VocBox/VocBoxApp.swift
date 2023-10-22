//
//  VocBoxApp.swift
//  VocBox
//
//  Created by Jessie P on 9/14/23.
//

import SwiftUI

@available(iOS 17.0, *)
@main
  struct VocBoxApp: App {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.createDate, order: .reverse)]) private var vocabs: FetchedResults<Vocab>
    
   
    
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .modifier(DarkModeViewModifier())
                .environment(\.managedObjectContext,CoreDataController().container.viewContext)
            /*
            if UserDefaults.standard.bool(forKey: AppConstants.hasVisitedAppKey) {
            
                ReviewVocView()
                    .modifier(DarkModeViewModifier())
                    .environment(\.managedObjectContext,CoreDataController().container.viewContext)
            }else {
                SplashScreenView()
                    .modifier(DarkModeViewModifier())
                    .environment(\.managedObjectContext,CoreDataController().container.viewContext)
                    .onAppear{
                        UserDefaults.standard.set(true, forKey: AppConstants.hasVisitedAppKey)
                    }
            }
             */
        }
    }
}
