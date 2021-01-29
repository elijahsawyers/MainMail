//
//  Menu.swift
//  Main Mail (macOS)
//
//  Created by Elijah Sawyers on 1/20/21.
//

import SwiftUI

struct Menu: View {
    @ObservedObject var mainMailManager: MainMailManager

    var body: some View {
        ScrollView {
            ScrollViewSpacer
            ForEach(mainMailManager.inbox) { email in
                let includeDivider =
                    mainMailManager.inbox.last != nil ?
                        email != mainMailManager.inbox.last! :
                        false
                MenuEmail(email, includeDivider: includeDivider)
            }
            ScrollViewSpacer
        }
        .frame(width: frame.width, height: frame.height)
    }
    
    // MARK: - Drawing Constant[s]
    
    private let frame: CGSize = CGSize(width: 350, height: 200)
    private let ScrollViewSpacer: some View = Spacer().frame(height: 10)
}
