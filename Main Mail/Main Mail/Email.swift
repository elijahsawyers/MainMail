//
//  Email.swift
//  Main Mail
//
//  Created by Elijah Sawyers on 1/31/21.
//

import Foundation

struct Email: Identifiable, Equatable, Comparable {
    private(set) var id: String
    private(set) var date: Date
    private(set) var from: String
    private(set) var subject: String
    private(set) var snippet: String
    
    static func ==(lhs: Email, rhs: Email) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func < (lhs: Email, rhs: Email) -> Bool {
        return lhs.date > rhs.date
    }
}
