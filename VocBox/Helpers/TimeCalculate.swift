//
//  TimeCalculate.swift
//  VocBox
//
//  Created by Jessie P on 9/19/23.
//

import Foundation

//MARK: func to calculate time after Add word
func timeSince(date: Date) -> String {
    let minutes = Int(-date.timeIntervalSinceNow)/60
    let hours = minutes/60
    let days = hours/24
    
    if  minutes >= 1  && minutes < 2  {
        return "\(minutes) minute ago"
    } else if minutes > 2 && minutes < 120{
        return "\(minutes) minutes ago"
        
    } else if minutes == 60 {
        return "\(hours) hour ago"
        
    } else if minutes >= 120 && hours < 48  {
        return "\(hours) hours ago"
        
    } else if days == 1 {
        return "\(days) day ado"
        
    } else {
        return "\(days) days ago"
    }
}
