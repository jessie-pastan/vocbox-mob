//
//  ReadWord.swift
//  VocBox
//
//  Created by Jessie Pastan on 10/11/23.
//

import Foundation
import AVFoundation

final class ReadWord {
    static func speakWord(vocabPronunciation : String, speechSynthesizer: AVSpeechSynthesizer) {
           let speechUtterance = AVSpeechUtterance(string: vocabPronunciation)
        
           let voiceIdentifier = "com.apple.ttsbundle.siri_male_en-US_compact"
           let voice = AVSpeechSynthesisVoice(identifier: voiceIdentifier)
    
           speechUtterance.voice = voice
           speechUtterance.rate = 0.4 // Adjust speech rate as needed
           speechSynthesizer.speak(speechUtterance)
       }
}
