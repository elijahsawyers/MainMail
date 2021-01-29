//
//  Menu.swift
//  Main Mail (macOS)
//
//  Created by Elijah Sawyers on 1/20/21.
//

import SwiftUI

struct Menu: View {
    var body: some View {
        ScrollView {
            ScrollViewSpacer
            ForEach(0..<5) { i in
                MenuEmail(includeDivider: i != 4)
            }
            ScrollViewSpacer
        }
        .frame(width: frame.width, height: frame.height)
    }
    
    // MARK: - Drawing Constant[s]
    
    private let frame: CGSize = CGSize(width: 350, height: 200)
    private let ScrollViewSpacer: some View = Spacer().frame(height: 10)
}
