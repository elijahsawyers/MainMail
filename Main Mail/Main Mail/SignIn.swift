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
            Button(action: {
//                let authorizationEndpoint = URL(string: "https://accounts.google.com/o/oauth2/v2/auth")!
//                let tokenEndpoint = URL(string: "https://www.googleapis.com/oauth2/v4/token")!
//                let configuration = OIDServiceConfiguration(authorizationEndpoint: authorizationEndpoint, tokenEndpoint: tokenEndpoint)
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.white)
                        .shadow(
                            color: Color(shadowColor),
                            radius: shadowRadius,
                            x: shadowX,
                            y: shadowY
                        )
                    HStack {
                        Image("Google")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .padding(.leading, 10)
                        Spacer()
                        Text("Sign in with Google")
                            .foregroundColor(.gray)
                            .font(Font.system(size: 12).bold())
                        Spacer()
                    }
                }
            })
                .buttonStyle(PlainButtonStyle())
                .frame(width: 200, height: 40)
        }
    }
    
    // MARK: - Drawing Constant[s]
    
    private var shadowColor: NSColor = NSColor.black.withAlphaComponent(0.25)
    private var shadowRadius: CGFloat = 1.5
    private var shadowX: CGFloat = 0.0
    private var shadowY: CGFloat = 5.0
}
