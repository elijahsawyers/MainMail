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
    @ObservedObject var mainMailManager: MainMailManager

    var body: some View {
        ScrollView {
            ScrollViewSpacer
            ForEach(emails) { email in
                if shouldShow(email: email.from) {
                    MenuEmail(email, includeDivider: email != emails.last)
                }
            }
            ScrollViewSpacer
        }
        .frame(width: frame.width, height: frame.height)
    }
    
    func shouldShow(email: String) -> Bool {
        // If there are no filters, show all emails.
        if mainMailManager.emailsToInclude.isEmpty { return true }
        
        // Check if the sender of the email is in the include list.
        for emailToShow in mainMailManager.emailsToInclude {
            if email.contains(emailToShow) { return true }
        }
        
        return false
    }
    
    // MARK: - Drawing Constant[s]
    
    private let frame: CGSize = CGSize(width: 350, height: 200)
    private let ScrollViewSpacer: some View = Spacer().frame(height: 10)
}
