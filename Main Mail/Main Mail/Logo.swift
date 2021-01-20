//
//  Logo.swift
//  Main Mail
//
//  Created by Elijah Sawyers on 1/20/21.
//

import SwiftUI

struct Logo: View {
    var body: some View {
        HStack {
            Text("\(Image(systemName: systemImageName))")
                .font(font)
                .bold()
            Text(appName)
                .font(font)
                .bold()
        }
        .shadow(
            color: Color(shadowColor),
            radius: shadowRadius,
            x: shadowX,
            y: shadowY
        )
    }
    
    // MARK: - Drawing Constant[s]
    
    private let font: Font = .system(size: 24)
    private let appName: String = "Main Mail"
    private let systemImageName: String = "envelope.fill"
    private var shadowColor: NSColor = NSColor.black.withAlphaComponent(0.25)
    private var shadowRadius: CGFloat = 1.5
    private var shadowX: CGFloat = 0.0
    private var shadowY: CGFloat = 5.0
}
