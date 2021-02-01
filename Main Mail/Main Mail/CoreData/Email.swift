//
//  Email.swift
//  Main Mail
//
//  Created by Elijah Sawyers on 1/31/21.
//

import SwiftUI

extension Email: Comparable {
    public static var entityName: String = "Email"

    public var id: String {
        get { id_! }
        set { id_ = newValue }
    }
    
    public var date: Date {
        get { date_! }
        set { date_ = newValue }
    }
    
    public var from: String {
        get { from_! }
        set { from_ = newValue }
    }
    
    public var subject: String {
        get { subject_! }
        set { subject_ = newValue }
    }

    public var snippet: String {
        get { snippet_! }
        set { snippet_ = newValue }
    }
    
    public static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<Email> {
        let request = NSFetchRequest<Email>(entityName: Email.entityName)
        request.sortDescriptors = [NSSortDescriptor(key: "date_", ascending: false)]
        request.predicate = predicate
        return request
    }
    
    public static func addToInbox(
        id: String,
        date: Date,
        from: String,
        subject: String,
        snippet: String,
        context: NSManagedObjectContext
    ) {
        let request = fetchRequest(NSPredicate(format: "id_ = %@", id))
        if (try? context.fetch(request))?.count != 0 { // Email already in inbox, discard it.
            return
        } else { // Email not in inbox, add it.
            let email = Email(context: context)
            email.id = id
            email.date = date
            email.from = from
            email.subject = subject
            email.snippet = snippet
            do {
                try context.save()
            } catch(let error) {
                print("Couldn't add email to CoreData: \(error.localizedDescription)")
            }
        }
    }
    
    public static func < (lhs: Email, rhs: Email) -> Bool {
        return lhs.date < rhs.date
    }
}
