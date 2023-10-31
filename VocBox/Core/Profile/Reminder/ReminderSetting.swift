//
//  ReminderSetting.swift
//  VocBox
//
//  Created by Jessie Pastan on 10/26/23.
//

import Foundation
import SwiftUI

struct ReminderSetting {
    @AppStorage("notificationsEnabled") static var notificationsEnabled: Bool = false
    //@AppStorage("selectedReminderTime") static var selectedReminderTime: Bool = true
}
