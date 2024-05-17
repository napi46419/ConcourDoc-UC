//
//  File.swift
//  
//
//  Created by Wadÿe on 04/05/2023.
//

import Foundation
import Cocoa

class EmailUtility: NSObject {
    static func send(to recipient: String, subject: String, body: String) async {
        let service = NSSharingService(named: .composeEmail)!
        service.recipients = [recipient]
        service.subject = subject
        DispatchQueue.main.async {
            service.perform(withItems: [body])
        }
    }
    
    static func send(to recipients: [String], subject: String, body: String) async {
        let service = NSSharingService(named: .composeEmail)!
        service.recipients = recipients
        service.subject = subject
        service.perform(withItems: [body])
    }
}
