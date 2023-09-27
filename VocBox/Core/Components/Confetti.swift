//
//  Confetti.swift
//  VocBox
//
//  Created by Jessie Pastan on 9/26/23.
//

import SwiftUI
import ConfettiSwiftUI

struct Confetti: View {
    @State var counter:Int

        var body: some View {
            ZStack{
                
                ConfettiCannon(counter: $counter, num: 50, openingAngle: Angle(degrees: 0), closingAngle: Angle(degrees: 360), radius: 200)
            }
        }
}

struct Confetti_Previews: PreviewProvider {
    static var previews: some View {
        Confetti(counter: 1)
    }
}
