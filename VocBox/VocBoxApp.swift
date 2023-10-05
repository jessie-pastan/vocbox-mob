//
//  VocBoxApp.swift
//  VocBox
//
//  Created by Jessie P on 9/14/23.
//

import SwiftUI

@main
struct VocBoxApp: App {
    
    
    var body: some Scene {
        WindowGroup {
            ReviewVocView()
                .modifier(DarkModeViewModifier())
                .environment(\.managedObjectContext,CoreDataController().container.viewContext)
            
            
        }
    }
}
