//
//  DarkMode.swift
//  VocBox
//
//  Created by Jessie Pastan on 10/4/23.
//

import Foundation
import SwiftUI

public struct DarkModeViewModifier: ViewModifier {

    @AppStorage("isDarkMode") var isDarkMode: Bool = false

    public func body(content: Content) -> some View {
        content
            .environment(\.colorScheme, isDarkMode ? .dark : .light)
            .preferredColorScheme(isDarkMode ? .dark : .light) 
    }
}
