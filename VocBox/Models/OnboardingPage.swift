//
//  OnboardingPage.swift
//  VocBox
//
//  Created by Jessie Pastan on 10/18/23.
//

import Foundation
struct OnboardingPage: Identifiable, Equatable {
    let id = UUID()
    var title: String
    var description1: String
    var description2: String
    var imageUrl: String
    var tag: Int
    
    static var samplePage = OnboardingPage(title: "Title Sample", description1: "Sample description", description2: "Sample2", imageUrl: "box", tag: 0)
    static var pages: [OnboardingPage] = [
        OnboardingPage(title: "Welcome to \n VocBox!", description1: "Effortlessly store", description2:  "your personal vocabulary", imageUrl: "boxLetterDropp", tag: 0),
        OnboardingPage(title: "     \n Voc Challenge", description1: "Train your vocabulary skills", description2:  "and track your progress" , imageUrl: "brain_lift_up", tag: 1)]
}
