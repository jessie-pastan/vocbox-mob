//
//  SendEmailView.swift
//  VocBox
//
//  Created by Jessie Pastan on 11/15/23.
//

import SwiftUI
import MessageUI


struct SendEmailButtonView: View {

      @State private var mailData = ComposeMailData(subject: "A subject",
                                                    recipients: ["i.love@swiftuirecipes.com"],
                                                    message: "Here's a message",
                                                    attachments: [AttachmentData(data: "Some text".data(using: .utf8)!,
                                                                                 mimeType: "text/plain",
                                                                                 fileName: "text.txt")
                                                   ])
     @State private var showMailView = false

      var body: some View {
        Button(action: {
          showMailView.toggle()
        }) {
          Text("Send mail")
        }.disabled(!MailView.canSendMail)
        .sheet(isPresented: $showMailView) {
          MailView(data: $mailData) { result in
            print(result)
           }
        }
      }
}
#Preview {
  SendEmailButtonView()
}
