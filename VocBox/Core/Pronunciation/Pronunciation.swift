//
//  PronunciationViewModel.swift
//  VocBox
//
//  Created by Jessie Pastan on 10/11/23.
//

import Foundation
import AVFoundation

class Pronunciation: ObservableObject {
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    func speakWord(phonetic : String) {
        let speechUtterance = AVSpeechUtterance(string: phonetic)
        speechUtterance.rate = 0.5 // Adjust speech rate as needed
        speechSynthesizer.speak(speechUtterance)
    }
}
