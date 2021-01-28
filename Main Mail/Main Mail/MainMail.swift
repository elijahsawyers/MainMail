//
//  MainMail.swift
//  Shared
//
//  Created by Elijah Sawyers on 1/19/21.
//

import SwiftUI

struct MainMail: View {
    @EnvironmentObject var mainMailManager: MainMailManager

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
            if let isSignedIn = mainMailManager.isSignedIn, !isSignedIn {
                SignIn()
            } else if let isSignedIn = mainMailManager.isSignedIn, isSignedIn {
                EmailFilter()
            }
        }
        .frame(width: width, height: height)
    }
    
    // MARK: - Drawing Constant[s]
    
    private let width: CGFloat = 600
    private let height: CGFloat = 400
}
