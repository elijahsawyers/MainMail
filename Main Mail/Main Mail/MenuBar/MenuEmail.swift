//
//  MenuEmail.swift
//  Main Mail
//
//  Created by Elijah Sawyers on 1/28/21.
//

import SwiftUI

struct MenuEmail: View {
    var includeDivider: Bool

    var body: some View {
        VStack() {
            HStack {
                MenuEmailFrom()
                Spacer()
                MenuEmailDate()
            }
            MenuEmailSubject()
            MenuEmailBody()
            if includeDivider { Divider() }
        }
        .frame(width: frame.width, height: frame.height)
    }
    
    // MARK: - Drawing Constant[s]
    
    private let frame: CGSize = CGSize(width: 350, height: 100)
}

struct MenuEmailFrom: View {
    var body: some View {
        Text("test@email.com")
            .padding(.leading, padding)
            .font(font)
            .frame(maxWidth: maxWidth)
            .lineLimit(lineLimit)
            .fixedSize()
    }
    
    // MARK: - Drawing Constant[s]
    
    private let font = Font.system(.body).bold()
    private let padding: CGFloat = 10.0
    private let maxWidth: CGFloat = 225.0
    private let lineLimit = 1
}

struct MenuEmailDate: View {
    var body: some View {
        Text("01-26-2021")
            .padding(.trailing, padding)
            .font(font)
            .frame(maxWidth: maxWidth)
            .lineLimit(lineLimit)
    }
    
    // MARK: - Drawing Constant[s]
    
    private let font = Font.system(.headline)
    private let padding: CGFloat = 10.0
    private let maxWidth: CGFloat = 125.0
    private let lineLimit = 1
}

struct MenuEmailSubject: View {
    var body: some View {
        HStack {
            Text("Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.")
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
    var body: some View {
        HStack {
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                .padding(.horizontal, padding)
                .font(font)
                .lineLimit(lineLimit)
            Spacer()
        }
    }
    
    // MARK: - Drawing Constant[s]
    
    private let font = Font.system(.body).bold()
    private let padding: CGFloat = 10.0
    private let lineLimit = 3
}
