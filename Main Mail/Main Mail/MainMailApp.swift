//
//  MainMailApp.swift
//  Shared
//
//  Created by Elijah Sawyers on 1/19/21.
//

import SwiftUI
import AppAuth

@main
struct MainMailApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var mainMailManager = MainMailManager(
        context: PersistenceController.shared.container.viewContext
    )

    var body: some Scene {
        WindowGroup {
            MainMail().onAppear {
                // Try to restore the previous authentication state.
                mainMailManager.isSignedIn = GoogleOAuth.restoreAuthState()
                
                // Pass the state object to the app delegate so that it can be accessed
                // from the menu bar.
                appDelegate.mainMailManager = mainMailManager
            }
                .environmentObject(mainMailManager)
        }
    }
}

/// Using the `AppDelegate` as there doesn't appear to be a way to add a menu bar item without it yet.
class AppDelegate: NSResponder, NSApplicationDelegate {
    let popover: NSPopover = NSPopover()
    var menuBarItem: NSStatusItem!
    var currentAuthorizationFlow: OIDExternalUserAgentSession?
    var mainMailManager: MainMailManager?

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Set the app delegate.
        NSApplication.shared.delegate = self
        
        // Configure the menu bar.
        self.menuBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        configureMenuBarItem()
    }
    
    func application(_ application: NSApplication, open urls: [URL]) {
        if let authorizationFlow = self.currentAuthorizationFlow,
            let url = urls.first,
            authorizationFlow.resumeExternalUserAgentFlow(with: url) {
            self.currentAuthorizationFlow = nil
        }
    }
    
    func applicationWillResignActive(_ notification: Notification) {
        closePopover(sender: self)
    }
}

/// Extension to configure the menu bar item.
extension AppDelegate {
    func configureMenuBarItem() {
        // Setup the NSMenu.
        menuBarItem.menu = NSMenu()

        // Configure the button image.
        if let button = self.menuBarItem.button {
            button.image = NSImage(systemSymbolName: "envelope", accessibilityDescription: nil)
            let clickGesture = NSClickGestureRecognizer(target: self, action: #selector(togglePopover(_:)))
            clickGesture.numberOfClicksRequired = 1
            button.addGestureRecognizer(clickGesture)
        }
        
        // Set the content.
        let menuView = Menu().environment(
            \.managedObjectContext,
            PersistenceController.shared.container.viewContext
        )
        popover.contentViewController = NSHostingController(rootView: menuView)
    }
    
    @objc func togglePopover(_ sender: Any?) {
        if popover.isShown {
            closePopover(sender: sender)
        } else {
            showPopover(sender: sender)
        }
    }
    
    func showPopover(sender: Any?) {
        if let button = menuBarItem.button {
            popover.behavior = NSPopover.Behavior.transient
            NSApp.activate(ignoringOtherApps: true)
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }
    
    func closePopover(sender: Any?) {
        popover.performClose(sender)
    }
}
