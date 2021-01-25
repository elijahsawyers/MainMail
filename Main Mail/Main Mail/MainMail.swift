//
//  MainMail.swift
//  Shared
//
//  Created by Elijah Sawyers on 1/19/21.
//

import SwiftUI

struct MainMail: View {
    @Binding var isSignedIn: Bool?

    var body: some View {
        ZStack {
            WaveBackground()
            VStack {
                HStack {
                    Logo()
                        .padding()
                    Spacer()
                }
                Spacer()
            }
            if let isSignedIn = isSignedIn, !isSignedIn {
                SignIn()
            } else if let isSignedIn = isSignedIn, isSignedIn {
                // TODO: give filter options to filter mail.
                Text("Hooray! Signed in!")
            }
        }
        .frame(width: width, height: height)
    }
    
    // MARK: - Drawing Constant[s]
    
    private let width: CGFloat = 600
    private let height: CGFloat = 400
}
