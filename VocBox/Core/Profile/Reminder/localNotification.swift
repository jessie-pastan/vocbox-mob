//
//  localNotification.swift
//  VocBox
//
//  Created by Jessie Pastan on 10/26/23.
//

import Foundation
import NotificationCenter


@MainActor
class LocalNotificationManager: ObservableObject {
    let notificationCenter = UNUserNotificationCenter.current()
    @Published var isGranted: Bool = false
    func requestAuthotization()async throws {
        try await notificationCenter
            .requestAuthorization(options: [.sound, .badge, .alert])
        await self.getCurrentAuthotizeState()
        
    }
    
    func getCurrentAuthotizeState() async {
        let currentSettings = await notificationCenter.notificationSettings()
        isGranted = (currentSettings.authorizationStatus == .authorized)
        print("DeBug : Phone setting status \(isGranted)")
    }
    
    func openPhoneSetting() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                Task {
                    UIApplication.shared.open(url)
                }
                
            }
            
        }
    }
    
    
    func sendNotifications(date: Date, title: String, body: String) {
        var trigger: UNNotificationTrigger?

        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
        trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotifications(){
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
