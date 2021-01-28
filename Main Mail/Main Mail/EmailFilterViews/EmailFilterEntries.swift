//
//  EmailFilterEntries.swift
//  Main Mail
//
//  Created by Elijah Sawyers on 1/27/21.
//

import SwiftUI

struct EmailFilterEntries: View {
    @EnvironmentObject private var mainMailManager: MainMailManager

    var body: some View {
        ScrollView {
            ForEach(mainMailManager.emailsToInclude.reversed(), id: \.self) { email in
                EmailFilterEntry(email: email)
                    .frame(
                        width: EmailFilterConstants.inputFrame.width,
                        height: EmailFilterConstants.inputFrame.height
                    )
            }
            Spacer().frame(height: bottomSpacerHeight)
        }
    }
    
    // MARK: - Drawing Constant[s]

    private let bottomSpacerHeight: CGFloat = 10
}
