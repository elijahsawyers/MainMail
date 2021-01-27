//
//  MainMailManager.swift
//  Main Mail
//
//  Created by Elijah Sawyers on 1/26/21.
//

import SwiftUI

struct Email {
    private(set) var id: String
    private(set) var date: String
    private(set) var from: String
    private(set) var subject: String
    private(set) var snippet: String
}

class MainMailManager: ObservableObject {
    @Published private(set) var inbox: [Email] = [] {
        didSet {
            print(inbox.last?.id ?? "N/A")
            print(inbox.last?.date ?? "N/A")
            print(inbox.last?.from ?? "N/A")
            print(inbox.last?.subject ?? "N/A")
            print(inbox.last?.snippet ?? "N/A")
            print("\n\n")
        }
    }
    @Published var isSignedIn: Bool = false {
        didSet {
            if isSignedIn {
//                gmailApi = GmailAPI(successHandler: { [weak self] _ in
//                    self?.fetchInbox()
//                })
            }
        }
    }
    private var gmailApi: GmailAPI?

    func fetchInbox() {
        gmailApi?.get(resource: .messages, successHandler: { response in
            if let response = response as? [String:Any],
               let messages = response["messages"] as? [[String:Any]] {
                for message in messages {
                    self.fetch(email: message)
                }
            }
        })
    }
    
    func fetch(email: [String:Any]) {
        if let id = email["id"] as? String {
            gmailApi?.get(resource: .message(id: id), successHandler: { response in
                if let response = response as? [String:Any],
                   let payload = response["payload"] as? [String:Any],
                   let snippet = response["snippet"] as? String,
                   let headers = payload["headers"] as? [[String:Any]] {
                        let (date, from, subject) = self.extractHeaderInformation(from: headers)
                        self.inbox.append(Email(
                            id: id,
                            date: date,
                            from: from,
                            subject: subject,
                            snippet: snippet
                        ))
                }
            })
        }
    }
    
    func extractHeaderInformation(from header: [[String:Any]]) -> (date: String, from: String, subject: String) {
        var date, from, subject: String
        
        date = header.filter { entry in
            (entry["name"] as? String) == "Date"
        }.first?["value"] as? String ?? "No Date"
        
        from = header.filter { entry in
            (entry["name"] as? String) == "From"
        }.first?["value"] as? String ?? "No Sender"
        
        subject = header.filter { entry in
            (entry["name"] as? String) == "Subject"
        }.first?["value"] as? String ?? "No Subject"
        
        return (date, from, subject)
    }
}
