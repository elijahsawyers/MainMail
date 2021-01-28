//
//  EmailFilterInput.swift
//  Main Mail
//
//  Created by Elijah Sawyers on 1/27/21.
//

import SwiftUI

struct EmailFilterInput: View {
    @EnvironmentObject private var mainMailManager: MainMailManager
    @State private var email: String = ""

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: EmailFilterConstants.inputFrame.height / 2)
                .foregroundColor(.white)
                .shadow(
                    color: Color(EmailFilterConstants.shadowColor),
                    radius: EmailFilterConstants.shadowRadius,
                    x: EmailFilterConstants.shadowX,
                    y: EmailFilterConstants.shadowY
                )
                .padding(.horizontal)
            HStack {
                Image(systemName: "bookmark.fill")
                    .colorMultiply(EmailFilterConstants.textColor)
                    .imageScale(.large)
                    .padding(.leading, EmailFilterConstants.padding)
                TextField("", text: $email, onCommit: {
                    mainMailManager.include(email: email)
                    email = ""
                    NSApp.keyWindow?.makeFirstResponder(nil)
                })
                    .font(EmailFilterConstants.font)
                    .textFieldStyle(PlainTextFieldStyle())
                    .colorMultiply(EmailFilterConstants.textColor)
                    .padding(.trailing, EmailFilterConstants.padding)
                    .onExitCommand(perform: {
                        email = ""
                        NSApp.keyWindow?.makeFirstResponder(nil)
                    })
            }
            .padding(.horizontal)
        }
        .frame(width: EmailFilterConstants.inputFrame.width, height: EmailFilterConstants.inputFrame.height)
    }
}
