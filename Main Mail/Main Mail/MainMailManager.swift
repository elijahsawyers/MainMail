//
//  MainMailManager.swift
//  Main Mail
//
//  Created by Elijah Sawyers on 1/26/21.
//

import SwiftUI

struct Email: Identifiable, Equatable {
    private(set) var id: String
    private(set) var date: Date
    private(set) var from: String
    private(set) var subject: String
    private(set) var snippet: String
    
    static func ==(_ lhs: Email, _ rhs: Email) -> Bool {
        return lhs.id == rhs.id
    }
}

class MainMailManager: ObservableObject {
    @Published private(set) var emailsToInclude = [String]()
    @Published private(set) var inbox: [Email] = []
    @Published var isSignedIn: Bool = false {
        didSet {
            if isSignedIn {
                gmailApi = GmailAPI(successHandler: { [weak self] _ in
                    self?.fetchInbox()
                })
            }
        }
    }
    private var gmailApi: GmailAPI?

    private func fetchInbox() {
        gmailApi?.get(resource: .messages, successHandler: { response in
            if let response = response as? [String:Any],
               let messages = response["messages"] as? [[String:Any]] {
                for message in messages {
                    self.fetch(email: message)
                }
            }
        })
    }
    
    private func fetch(email: [String:Any]) {
        if let id = email["id"] as? String {
            gmailApi?.get(resource: .message(id: id), successHandler: { response in
                if let response = response as? [String:Any],
                   let payload = response["payload"] as? [String:Any],
                   let snippet = response["snippet"] as? String,
                   let headers = payload["headers"] as? [[String:Any]] {
                        let (date, from, subject) = self.extractHeaderInformation(from: headers)
                        self.inbox.append(Email(
                            id: id,
                            date: Date.from(string: date)!,
                            from: String(htmlEncodedString: from) ?? from,
                            subject: String(htmlEncodedString: subject) ?? subject,
                            snippet: String(htmlEncodedString: snippet) ?? snippet
                        ))
                }
            })
        }
    }
    
    private func extractHeaderInformation(from header: [[String:Any]]) -> (date: String, from: String, subject: String) {
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
    
    // MARK: - Intent[s]
    
    func include(email: String) {
        if !email.isEmpty, !emailsToInclude.contains(email) {
            emailsToInclude.append(email)
        }
    }
    
    func exclude(email: String) {
        if !email.isEmpty, emailsToInclude.contains(email) {
            emailsToInclude.removeAll(where: { $0 == email})
        }
    }
}
