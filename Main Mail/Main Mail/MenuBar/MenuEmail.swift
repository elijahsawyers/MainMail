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
            MenuEmailFrom(from: email.formattedFrom)
            MenuEmailDate(date: email.date)
            MenuEmailSubject(subject: email.subject)
            MenuEmailBody(snippet: email.snippet)
            if includeDivider { Divider() }
        }
        .frame(width: frameWidth)
    }
    
    // MARK: - Drawing Constant[s]
    
    private let frameWidth: CGFloat = 350.0
}

struct MenuEmailFrom: View {
    var from: String

    var body: some View {
        HStack {
            Text(from)
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

    var body: some View {
        HStack {
            Text(subject)
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

    var body: some View {
        HStack {
            Text(snippet)
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
