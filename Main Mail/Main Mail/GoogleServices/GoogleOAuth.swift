//
//  GoogleOAuth.swift
//  Main Mail
//
//  Created by Elijah Sawyers on 1/24/21.
//

import Foundation
import AppAuth
import KeychainSwift

struct GoogleOAuth {
    /// Google app client ID.
    static private let clientID = "808492754173-ovtoe0kks7chj4t8dml68cmvanr8ei60.apps.googleusercontent.com"
    
    /// Redirect URI for the auth server.
    static private let redirectURI = URL(string: "me.elijahsawyers.main-mail:/oath2Callback")!
    
    /// Google OAuth authorization endpoint.
    static private let authorizationEndpoint = URL(string: "https://accounts.google.com/o/oauth2/auth")!
    
    /// Google OAuth token endpoint.
    static private let tokenEndpoint = URL(string: "https://accounts.google.com/o/oauth2/token")!
    
    /// AppAuth configuration to construct `OIDAuthorizationRequest` in the `signIn` method.
    static private var configuration = OIDServiceConfiguration(
        authorizationEndpoint: authorizationEndpoint,
        tokenEndpoint: tokenEndpoint
    )
    
    /// Stores the authorization state. The value will be `nil` if the user has never signed in using `signIn`.
    static var authState: OIDAuthState?
    
    /// The key used for storing the `OIDAuthState` in keychain.
    static private let authStateKeychainKey = "main-mail.authstate"
    
    /// Whether or not the user authorization has already happened.
    static var isAuthorized: Bool {
        return authState?.isAuthorized ?? false
    }

    /// Used the sign the user into their Google account for Gmail access.
    static func signIn(_ successHandler: @escaping () -> Void, _ errorHandler: @escaping (Error?) -> Void) {
        let request = OIDAuthorizationRequest(
            configuration: configuration,
            clientId: clientID,
            clientSecret: nil,
            scopes: [OIDScopeOpenID, OIDScopeProfile, "https://mail.google.com/", "https://www.googleapis.com/auth/userinfo.email"],
            redirectURL: redirectURI,
            responseType: OIDResponseTypeCode,
            additionalParameters: nil
        )
        
        (NSApplication.shared.delegate as! AppDelegate).currentAuthorizationFlow = OIDAuthState.authState(
            byPresenting: request,
            externalUserAgent: OIDExternalUserAgentMac()
        ) { authState, error in
            if let authState = authState {
                self.authState = authState
                if let data = try? NSKeyedArchiver.archivedData(withRootObject: authState, requiringSecureCoding: true) {
                    KeychainSwift().set(data, forKey: authStateKeychainKey)
                }
                successHandler()
            } else {
                self.authState = nil
                errorHandler(error)
            }
        }
    }
    
    /// Attempts to restore the previous `OIDAuthState` object.
    ///
    /// If the function was able to restore the authentication state, the object is stored
    /// in `authState` and returns `true`; otherwise, returns `false`.
    @discardableResult
    static func restoreAuthState() -> Bool {
        if let data = KeychainSwift().getData(authStateKeychainKey),
           let authState = try? NSKeyedUnarchiver.unarchivedObject(ofClass: OIDAuthState.self, from: data) {
            self.authState = authState
            return true
        } else {
            return false
        }
    }
    
    /// Removes the previous `OIDAuthState` object from `Self` and from the keychain.
    static func removeAuthState() {
        KeychainSwift().delete(authStateKeychainKey)
        authState = nil
    }
}
