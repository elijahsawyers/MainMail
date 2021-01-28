//
//  EmailFilter.swift
//  Main Mail
//
//  Created by Elijah Sawyers on 1/26/21.
//

import SwiftUI

/// Drawing constants used throughout the EmailFilter views.
struct EmailFilterConstants {
    static var font: Font = Font.system(size: 16).bold()
    static var shadowColor: NSColor = NSColor.black.withAlphaComponent(0.25)
    static var shadowRadius: CGFloat = 1.5
    static var shadowX: CGFloat = 0.0
    static var shadowY: CGFloat = 5.0
    static var textColor: Color = Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 1)
    static var padding: CGFloat = 10.0
    static var inputFrame: CGSize = CGSize(width: 400.0, height: 35.0)
}

struct EmailFilter: View {
    var body: some View {
        VStack {
            Spacer()
                .frame(height: topSpacerHeight)
            Text("Add email addresses to include in your Main Mail inbox.")
                .font(EmailFilterConstants.font)
                .shadow(
                    color: Color(EmailFilterConstants.shadowColor),
                    radius: EmailFilterConstants.shadowRadius,
                    x: EmailFilterConstants.shadowX,
                    y: EmailFilterConstants.shadowY
                )
            EmailFilterInput()
            Spacer()
                .frame(height: middleSpacerHeight)
            EmailFilterEntries()
        }
    }
    
    // MARK: - Drawing Constant[s]
    
    private let topSpacerHeight: CGFloat = 90
    private let middleSpacerHeight: CGFloat = 25
}

extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get { .none }
        set { }
    }
}
