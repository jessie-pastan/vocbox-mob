//
//  ReadWord.swift
//  VocBox
//
//  Created by Jessie Pastan on 10/11/23.
//

import Foundation
import AVFoundation

class ReadWord {
    static func speakWord(vocabPronunciation : String, speechSynthesizer: AVSpeechSynthesizer) {
           let speechUtterance = AVSpeechUtterance(string: vocabPronunciation)
           speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
           speechUtterance.rate = 0.4 // Adjust speech rate as needed
           speechSynthesizer.speak(speechUtterance)
       }
}
