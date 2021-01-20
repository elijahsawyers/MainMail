//
//  MainMailApp.swift
//  Shared
//
//  Created by Elijah Sawyers on 1/19/21.
//

import SwiftUI

@main
struct MainMailApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            MainMail()
        }
    }
}

/// Using the `AppDelegate` as there doesn't appear to be a way to add a menu bar item without it yet.
class AppDelegate: NSObject, NSApplicationDelegate {
    var menuBarItem: NSStatusItem!

    func applicationDidFinishLaunching(_ notification: Notification) {
        self.menuBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        configureMenuBarItem()
    }
}

/// Extension to configure the menu bar item.
extension AppDelegate {
    func configureMenuBarItem() {
        // Setup the NSMenu.
        self.menuBarItem.menu = Menu()

        // Configure the button image.
        if let button = self.menuBarItem.button {
            button.image = NSImage(systemSymbolName: "envelope", accessibilityDescription: nil)
        }
    }
}
