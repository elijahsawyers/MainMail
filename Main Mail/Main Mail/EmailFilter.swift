//
//  EmailFilter.swift
//  Main Mail
//
//  Created by Elijah Sawyers on 1/26/21.
//

import SwiftUI

struct EmailFilter: View {
    @State private var text: String = ""

    var body: some View {
        VStack {
            Text("Add an email address to your Main Mail inbox.")
                .font(font)
                .shadow(
                    color: Color(shadowColor),
                    radius: shadowRadius,
                    x: shadowX,
                    y: shadowY
                )
            ZStack {
                RoundedRectangle(cornerRadius: inputFrame.height / 2)
                    .foregroundColor(.white)
                    .shadow(
                        color: Color(shadowColor),
                        radius: shadowRadius,
                        x: shadowX,
                        y: shadowY
                    )
                HStack() {
                    Image(systemName: "bookmark.fill")
                        .colorMultiply(textColor)
                        .imageScale(.large)
                        .padding(.leading, padding)
                    TextField("", text: $text)
                        .font(font)
                        .textFieldStyle(PlainTextFieldStyle())
                        .colorMultiply(textColor)
                        .padding(.trailing, padding)
                }
            }
            .frame(width: inputFrame.width, height: inputFrame.height)
        }
    }
    
    // MARK: - Drawing Constant[s]
    
    private var font: Font = Font.system(size: 16).bold()
    private var shadowColor: NSColor = NSColor.black.withAlphaComponent(0.25)
    private var shadowRadius: CGFloat = 1.5
    private var shadowX: CGFloat = 0.0
    private var shadowY: CGFloat = 5.0
    private var textColor: Color = Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 1)
    private var padding: CGFloat = 10.0
    private var inputFrame: CGSize = CGSize(width: 300.0, height: 35.0)
}

extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get { .none }
        set { }
    }
}
