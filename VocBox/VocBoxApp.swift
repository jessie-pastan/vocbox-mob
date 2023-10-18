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
    
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .modifier(DarkModeViewModifier())
                .environment(\.managedObjectContext,CoreDataController().container.viewContext)
        }
    }
}
