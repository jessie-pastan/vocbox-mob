//
//  EmailController.swift
//  VocBox
//
//  Created by Jessie Pastan on 11/15/23.
//

import Foundation
import MessageUI

class EmailController: NSObject, MFMailComposeViewControllerDelegate {
    
    public static let shared = EmailController()
   
    private override init() { }
    
    
    private func showEmailSentAlert() {
        let alert = UIAlertController(title: "We've got you!",
                                      message: "Email sent successfully.",
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        guard let rootVC = EmailController.getRootViewController() else {
            print("Unable to get root view controller.")
            return
        }
        
        rootVC.present(alert, animated: true, completion: nil)
    }
    
    
    private func showEmailErrorAlert() {
        let alert = UIAlertController(title: "Unable to Send Email",
                                      message: "Mail is not configured",
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        guard let rootVC = EmailController.getRootViewController() else {
            print("Unable to get root view controller.")
            return
        }
        
        rootVC.present(alert, animated: true, completion: nil)
    }
    
    func sendEmail(subject:String, body:String, to:String){
        // Check if the device is able to send emails
        
        guard MFMailComposeViewController.canSendMail() else {
              showEmailErrorAlert()
              return
          }
        // Create the email composer
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setToRecipients([to])
        mailComposer.setSubject(subject)
        mailComposer.setMessageBody(body, isHTML: false)
        EmailController.getRootViewController()?.present(mailComposer, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        EmailController.getRootViewController()?.dismiss(animated: true, completion: nil)
        //give user feedback. we've got their email
        if result == .sent {
               showEmailSentAlert()
           }
    }
    
    static func getRootViewController() -> UIViewController? {
        if let windowScene = UIApplication.shared.connectedScenes
            .first(where: { $0 is UIWindowScene }) as? UIWindowScene {
            return windowScene.windows.first?.rootViewController
        }
        return nil
    }
}
