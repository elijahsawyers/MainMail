//
//  EmailFilterEntry.swift
//  Main Mail
//
//  Created by Elijah Sawyers on 1/27/21.
//

import SwiftUI

struct EmailFilterEntry: View {
    @EnvironmentObject private var mainMailManager: MainMailManager
    var email: String

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: geometry.size.height / 2)
                    .foregroundColor(.white)
                    .shadow(
                        color: Color(EmailFilterConstants.shadowColor),
                        radius: EmailFilterConstants.shadowRadius,
                        x: EmailFilterConstants.shadowX,
                        y: EmailFilterConstants.shadowY
                    )
                RoundedRectangle(cornerRadius: geometry.size.height / 2)
                    .stroke(borderColor)
                HStack {
                    Image(systemName: "trash.fill")
                        .foregroundColor(trashColor)
                        .imageScale(.large)
                        .padding(.leading, EmailFilterConstants.padding)
                        .onHover { inside in
                            if inside {
                                NSCursor.pointingHand.push()
                            } else {
                                NSCursor.pop()
                            }
                        }
                        .onTapGesture {
                            mainMailManager.exclude(email: email)
                        }
                    Text(email)
                        .font(EmailFilterConstants.font)
                        .colorMultiply(EmailFilterConstants.textColor)
                    Spacer()
                }
            }
            .padding(.horizontal)
        }
    }
    
    // MARK: - Drawing Constant[s]
    
    private let trashColor: Color = Color.red.opacity(0.75)
    private let borderColor: Color = Color.black.opacity(0.1)
}
