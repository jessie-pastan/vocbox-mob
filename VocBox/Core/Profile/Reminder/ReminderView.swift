//
//  ReminderView.swift
//  VocBox
//
//  Created by Jessie Pastan on 10/5/23.
//

import SwiftUI
import CoreData

struct ReminderView: View {
    
    
    var user: User
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var localNotificationManager: LocalNotificationManager
    @Environment(\.scenePhase) var scencePhase
    @Environment(\.dismiss) var dismiss
    @State private var isEnabledNotification: Bool = false
    @State private var selectedTime: Date
    @State private var isShowingAlert: Bool =  false
  
    init(user: User) {
        self.user = user
        self._selectedTime = State(initialValue: user.viewReminderTime)
    }
    
    var body: some View {
        
       
        
        VStack {
           
           
            List{
                
                    Toggle("Daily Reminder", isOn: $isEnabledNotification)
                        .tint(Color(.button))
                        .foregroundColor(Color.text)
                        .listRowBackground(Color.card)
                        .onTapGesture {
                            if localNotificationManager.isGranted == false {
                                //display alert to open phone setting
                                isShowingAlert = true
                            }
                            
                            
                            if isEnabledNotification {
                                print("Debug : view enable = \(isEnabledNotification)")
                                localNotificationManager.cancelNotifications()
                                ReminderSetting.notificationsEnabled = false
                                print("Debug : switched enable = false")
                                print("Debug: cancel noti")
                            }else {
                                //when user turn toggle
                                //switch appstorage to true
                                ReminderSetting.notificationsEnabled = true
                                print("Debug : switched enable = true")
                                
                            }
                        }
                        .alert("Please grant permission to send notification",
                               isPresented: $isShowingAlert) {
                            HStack{
                                Button{
                                    //Navigate to phone setting
                                    localNotificationManager.openPhoneSetting()
                                    
                                } label: {
                                    Text("Setting")
                                }
                                
                                Button(role: .cancel){
                                    //Dismiss alert
                                } label: {
                                    Text("Cancle")
                                }
                                
                            }
                            
                        }
                    
                    if isEnabledNotification {
                        
                        DatePicker("Selected time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                            
                        .foregroundColor(Color.text)
                        .listRowBackground(Color.card)
                        
                    }
                    
                    
                    Text("Get a daily notification from VocBox to remind the time of vocab study.")
                    .foregroundColor(Color.text)
                    .listRowBackground(Color.card)
                    
            }   
                .foregroundColor(Color.text)
                .scrollContentBackground(.hidden)
                .scrollDisabled(true)
        }
        .background(Color.background)
        .onAppear{
            isEnabledNotification = ReminderSetting.notificationsEnabled
            
         }
        .task{
            try? await localNotificationManager.requestAuthotization()
        }
        .onChange(of: scencePhase) {  newValue in
            if newValue == .active {
                Task {
                    await localNotificationManager.getCurrentAuthotizeState()
               }
           }
        }
        
        .toolbar {
            Button {
                if ReminderSetting.notificationsEnabled == false {
                    dismiss()
                }else {
                    //save setting time of notification
                    localNotificationManager.sendNotifications(date: selectedTime, title: "VocBoc Reminder", body: "It's time to review your vocab!")
                    print("Debug : Saved reminder")
                    
                    //save selectedTime into Core Data
                    CoreDataController().editUserReminderTime(item: user, context: moc, selectedTime: selectedTime)
                    
                    //dismiss
                    dismiss()
                }
                
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 120)
                        .frame(height: 20)
                        .foregroundColor(Color.button)
                    Text("Save")
                        .padding()
                        .bold()
                        .foregroundColor(Color.text)
                }
                .background(Rectangle().frame(height: 20).foregroundColor(.textField).cornerRadius(120).offset(x: 2, y: 2))
                .padding(.top, 5)
                .padding(.leading, -5)
                
            }
        }
    }
}


