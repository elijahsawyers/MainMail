//
//  SignOutButton.swift
//  Main Mail
//
//  Created by Elijah Sawyers on 2/1/21.
//

import SwiftUI

struct SignOutButton: View {
    var text: String
    var action: () -> Void
    
    init(text: String = "Sign Out", action: @escaping () -> Void) {
        self.text = text
        self.action = action
    }
    
    var body: some View {
        Button(action: action, label: {
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundColor(.white)
                    .shadow(
                        color: Color(shadowColor),
                        radius: shadowRadius,
                        x: shadowX,
                        y: shadowY
                    )
                Text(text)
                    .foregroundColor(.gray)
                    .font(font)
                    .padding(.horizontal)
            }
        })
            .buttonStyle(PlainButtonStyle())
            .frame(height: 30)
            .fixedSize()
            .padding()
            .onHover { inside in
                if inside {
                    NSCursor.pointingHand.push()
                } else {
                    NSCursor.pop()
                }
            }
    }

    // MARK: - Drawing Constant[s]
    
    private var shadowColor: NSColor = NSColor.black.withAlphaComponent(0.25)
    private var shadowRadius: CGFloat = 1.5
    private var shadowX: CGFloat = 0.0
    private var shadowY: CGFloat = 5.0
    private let cornerRadius: CGFloat = 10.0
    private let font: Font = Font.system(size: 12).bold()
}
