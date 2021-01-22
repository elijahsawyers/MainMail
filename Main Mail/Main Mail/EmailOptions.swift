//
//  EmailOptions.swift
//  Main Mail (macOS)
//
//  Created by Elijah Sawyers on 1/21/21.
//

import SwiftUI

struct EmailOptions: View {
    var body: some View {
        VStack {
            Text("Customize email options.")
                .font(Font.system(size: 16).bold())
                .shadow(
                    color: Color(shadowColor),
                    radius: shadowRadius,
                    x: shadowX,
                    y: shadowY
                )
            Button(action: {
                // TODO: Read mail
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
                    Text("Read mail")
                        .foregroundColor(.gray)
                        .font(Font.system(size: 12).bold())
                }
            })
                .buttonStyle(PlainButtonStyle())
                .frame(width: 200, height: 50)
        }
    }
    
    // MARK: - Drawing Constant[s]
    
    private var shadowColor: NSColor = NSColor.black.withAlphaComponent(0.25)
    private var shadowRadius: CGFloat = 1.5
    private var shadowX: CGFloat = 0.0
    private var shadowY: CGFloat = 5.0
}
