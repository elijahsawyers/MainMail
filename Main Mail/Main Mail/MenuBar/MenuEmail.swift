//
//  MenuEmail.swift
//  Main Mail
//
//  Created by Elijah Sawyers on 1/28/21.
//

import SwiftUI

struct MenuEmail: View {
    var email: Email
    var includeDivider: Bool

    init(_ email: Email, includeDivider: Bool = true) {
        self.email = email
        self.includeDivider = includeDivider
    }

    var body: some View {
        VStack() {
            MenuEmailFrom(email.from)
            MenuEmailDate(email.date)
            MenuEmailSubject(email.subject)
            MenuEmailBody(email.snippet)
            if includeDivider { Divider() }
        }
        .frame(width: frameWidth)
    }
    
    // MARK: - Drawing Constant[s]
    
    private let frameWidth: CGFloat = 350.0
}

struct MenuEmailFrom: View {
    var from: String
    
    init(_ from: String) {
        self.from = from
    }

    var body: some View {
        HStack {
            Text(String(htmlEncodedString: from) ?? from)
                .padding(.horizontal, padding)
                .font(font)
                .lineLimit(lineLimit)
            Spacer()
        }
    }
    
    // MARK: - Drawing Constant[s]
    
    private let font = Font.system(.body).bold()
    private let padding: CGFloat = 10.0
    private let lineLimit = 1
}

struct MenuEmailDate: View {
    var date: Date
    
    init(_ date: Date) {
        self.date = date
    }

    var body: some View {
        HStack {
            Text("\(date.mediumDateTime)")
                .padding(.horizontal, padding)
                .font(font)
                .lineLimit(lineLimit)
            Spacer()
        }
    }
    
    // MARK: - Drawing Constant[s]
    
    private let font = Font.system(.headline)
    private let padding: CGFloat = 10.0
    private let lineLimit = 1
}

struct MenuEmailSubject: View {
    var subject: String
    
    init(_ subject: String) {
        self.subject = subject
    }

    var body: some View {
        HStack {
            Text(String(htmlEncodedString: subject) ?? subject)
                .padding(.horizontal, padding)
                .font(font)
                .lineLimit(lineLimit)
            Spacer()
        }
    }
    
    // MARK: - Drawing Constant[s]
    
    private let font = Font.system(.body).bold()
    private let padding: CGFloat = 10.0
    private let lineLimit = 1
}

struct MenuEmailBody: View {
    var snippet: String
    
    init(_ snippet: String) {
        self.snippet = snippet
    }

    var body: some View {
        HStack {
            Text(String(htmlEncodedString: snippet) ?? snippet)
                .padding(.horizontal, padding)
                .font(font)
                .lineLimit(lineLimit)
            Spacer()
        }
    }
    
    // MARK: - Drawing Constant[s]
    
    private let font = Font.system(.body)
    private let padding: CGFloat = 10.0
    private let lineLimit = 3
}
