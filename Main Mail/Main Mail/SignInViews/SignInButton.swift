//
//  SignInButton.swift
//  Main Mail
//
//  Created by Elijah Sawyers on 1/24/21.
//

import SwiftUI

struct SignInButton: View {
    var image: String
    var text: String
    var action: () -> Void
    
    init(image: String, text: String, action: @escaping () -> Void) {
        self.image = image
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
                HStack {
                    Image(image)
                        .resizable()
                        .frame(width: frame.width, height: frame.height)
                        .padding(.leading, imagePadding)
                    Spacer()
                    Text(text)
                        .foregroundColor(.gray)
                        .font(font)
                    Spacer()
                }
            }
        })
            .buttonStyle(PlainButtonStyle())
            .frame(width: 200, height: 40)
    }

    // MARK: - Drawing Constant[s]
    
    private var shadowColor: NSColor = NSColor.black.withAlphaComponent(0.25)
    private var shadowRadius: CGFloat = 1.5
    private var shadowX: CGFloat = 0.0
    private var shadowY: CGFloat = 5.0
    private let cornerRadius: CGFloat = 10.0
    private let frame: CGSize = .init(width: 25.0, height: 25.0)
    private let imagePadding: CGFloat = 10.0
    private let font: Font = Font.system(size: 12).bold()
}
