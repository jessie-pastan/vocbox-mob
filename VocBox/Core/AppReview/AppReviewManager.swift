//
//  AppReviewManager.swift
//  VocBox
//
//  Created by Jessie Pastan on 11/14/23.
//

import Foundation
import StoreKit

class AppReviewManager : ObservableObject {
    
    var linkReview = URL(string: "https://apps.apple.com/app/id6471903173?action=write-review")
    
    private let userDefaults = UserDefaults.standard
    private let limit: Int = 20
    private let thresholdSet: Set<Int> = [5,15,25,50]
    

    //MARK: Verify to prompt a write review to user
    //call this fuction after user get 100% score 
    func canAskForReview(userVocab: Int) -> Bool {
        
       let mostRecentReviewed = userDefaults.string(forKey: AppConstants.lastReviewedVersionKey)
      
       guard let currentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else {
            fatalError("Expected to find a bundle version in the info dictionary")
        }
        //modify this function after user get 100% scrore and Verify if user hit 5th, 15th, 25th saved vocab in storage
        let reachedThreshold = thresholdSet.contains(userVocab)

        //Verify version is user's latest version
        let isNewVersion = currentVersion != mostRecentReviewed
        
        guard reachedThreshold && isNewVersion else {
            //if it's not reach threshold and if it's not new app  or if it's not hit score limit and not new app version return false
            return false
        }
        //save current version to user default
        userDefaults.set(currentVersion, forKey: AppConstants.lastReviewedVersionKey)
        return true
    }
    
    //call this funtion after user tap quit
    func askForReview() -> Bool {
        let mostRecentReviewed = userDefaults.string(forKey: AppConstants.lastReviewedVersionKey)
        let savedScore = userDefaults.integer(forKey: AppConstants.totalChallengeScore)
        guard let currentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else {
            fatalError("Expected to find a bundle version in the info dictionary")
        }
        //modify this function after user get 100% scrore and Verify if user hit 5th, 15th, 25th saved vocab in storage
        let scoreLimitHit =  savedScore.isMultiple(of: limit)
    
       
        let isNewVersion = currentVersion != mostRecentReviewed
        
        guard scoreLimitHit && isNewVersion else {
            //if it's not reach threshold and if it's not new app  or if it's not hit score limit and not new app version return false
            return false
        }
        //save current version to user default
        userDefaults.set(currentVersion, forKey: AppConstants.lastReviewedVersionKey)
        return true
        
        
    }
    
}
