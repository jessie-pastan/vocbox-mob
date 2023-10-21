//
//  FontExtention.swift
//  VocBox
//
//  Created by Jessie Pastan on 10/19/23.
//

import SwiftUI
extension Font {
    static func custom(_ font: CustomFont, size: CGFloat) -> SwiftUI.Font {
        SwiftUI.Font.custom(font.rawValue, size: size)
    }
}
