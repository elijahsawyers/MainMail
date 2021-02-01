//
//  MainMailManager.swift
//  Main Mail
//
//  Created by Elijah Sawyers on 1/26/21.
//

import SwiftUI
import CoreData

class MainMailManager: ObservableObject {
    static private let emailsToIncludeUserDefaultsKey = "MainMain.EmailsToInclude"
    @Published private(set) var emailsToInclude = [String]()
    @Published var isSignedIn: Bool = false {
        didSet {
            // Once it's been established that the user is signed in,
            // setup the timer to fetch inbox every minute.
            if isSignedIn {
                timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { timer in
                    self.fetchInbox()
                }
                gmailApi = GmailAPI(successHandler: { [weak self] _ in
                    self?.timer?.fire()
                })
            }
        }
    }
    private var gmailApi: GmailAPI?
    private var context: NSManagedObjectContext
    private var timer: Timer?

    init(context: NSManagedObjectContext) {
        self.context = context
        if let emailsToInclude =
            UserDefaults.standard.array(forKey: Self.emailsToIncludeUserDefaultsKey) as? [String] {
            self.emailsToInclude = emailsToInclude
        }
    }
    
    deinit {
        timer?.invalidate()
    }

    private func fetchInbox() {
        var resource: GmailAPI.RESTResource = .messages()
        let request = Email.fetchRequest(.all)
        request.fetchLimit = 1
        if let lastEmail = (try? context.fetch(request))?.first {
            resource = .messages(after: lastEmail.date)
        }
        gmailApi?.get(resource: resource, successHandler: { response in
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
                        Email.addToInbox(
                            id: id,
                            date: Date.from(string: date)!,
                            from: from,
                            formattedFrom: String(htmlEncodedString: from) ?? from,
                            subject: String(htmlEncodedString: subject) ?? subject,
                            snippet: String(htmlEncodedString: snippet) ?? snippet,
                            context: self.context
                        )
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
            UserDefaults.standard.setValue(emailsToInclude, forKey: Self.emailsToIncludeUserDefaultsKey)
        }
    }
    
    func exclude(email: String) {
        if !email.isEmpty, emailsToInclude.contains(email) {
            emailsToInclude.removeAll(where: { $0 == email})
            UserDefaults.standard.setValue(emailsToInclude, forKey: Self.emailsToIncludeUserDefaultsKey)
        }
    }
    
    func signOut() {
        // Invalidate the email fetching timer.
        timer?.invalidate()
        
        // Remove the instance of the GmailAPI.
        gmailApi = nil
        
        // Clear User Defaults.
        UserDefaults.standard.setValue(nil, forKey: Self.emailsToIncludeUserDefaultsKey)
        
        // Clear Core Data.
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Email.entityName)
        fetchRequest.returnsObjectsAsFaults = false
        if let results = try? context.fetch(fetchRequest) {
            for object in results {
                guard let objectData = object as? NSManagedObject else { continue }
                context.delete(objectData)
            }
            try? context.save()
        }
        
        // Clear the emailsToInclude.
        emailsToInclude = []
        
        // Remove the auth state.
        GoogleOAuth.removeAuthState()
        
        // Change the isSignedIn flag.
        isSignedIn = false
    }
}
