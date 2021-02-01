//
//  Menu.swift
//  Main Mail (macOS)
//
//  Created by Elijah Sawyers on 1/20/21.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) var context: NSManagedObjectContext
    @FetchRequest(fetchRequest: Email.fetchRequest(.all)) var emails: FetchedResults<Email>

    var body: some View {
        ScrollView {
            ScrollViewSpacer
            ForEach(emails) { email in
                MenuEmail(email, includeDivider: email != emails.last)
            }
            ScrollViewSpacer
        }
        .frame(width: frame.width, height: frame.height)
    }
    
    // MARK: - Drawing Constant[s]
    
    private let frame: CGSize = CGSize(width: 350, height: 200)
    private let ScrollViewSpacer: some View = Spacer().frame(height: 10)
}
