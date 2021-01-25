//
//  SignIn.swift
//  Main Mail (macOS)
//
//  Created by Elijah Sawyers on 1/21/21.
//

import SwiftUI

struct SignIn: View {
    var body: some View {
        VStack() {
            Text("Sign into your email below.")
                .font(Font.system(size: 16).bold())
                .shadow(
                    color: Color(shadowColor),
                    radius: shadowRadius,
                    x: shadowX,
                    y: shadowY
                )
            SignInButton(image: "Google", text: "Sign in with Google") {
                GoogleOAuth.signIn({
                    // TODO: Change app state for successful sign in.
                }, { error in
                    // TODO: Alert the user that the login failed.
                })
            }
        }
    }
    
    // MARK: - Drawing Constant[s]
    
    private var shadowColor: NSColor = NSColor.black.withAlphaComponent(0.25)
    private var shadowRadius: CGFloat = 1.5
    private var shadowX: CGFloat = 0.0
    private var shadowY: CGFloat = 5.0
}
