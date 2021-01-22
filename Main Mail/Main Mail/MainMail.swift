//
//  MainMail.swift
//  Shared
//
//  Created by Elijah Sawyers on 1/19/21.
//

import SwiftUI

struct MainMail: View {
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
            EmailOptions()
        }
        .frame(width: width, height: height)
    }
    
    // MARK: - Drawing Constant[s]
    
    private let width: CGFloat = 600
    private let height: CGFloat = 400
}
