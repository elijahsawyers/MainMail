//
//  GoogleOAuth.swift
//  Main Mail
//
//  Created by Elijah Sawyers on 1/24/21.
//

import Foundation
import AppAuth

class GoogleOAuth {
    static private let clientID = "808492754173-ovtoe0kks7chj4t8dml68cmvanr8ei60.apps.googleusercontent.com"
    static private let redirectURI = URL(string: "me.elijahsawyers.main-mail:/oath2Callback")!
    static private let authorizationEndpoint = URL(string: "https://accounts.google.com/o/oauth2/auth")!
    static private let tokenEndpoint = URL(string: "https://accounts.google.com/o/oauth2/token")!
    static private var configuration = OIDServiceConfiguration(
        authorizationEndpoint: authorizationEndpoint,
        tokenEndpoint: tokenEndpoint
    )
    static private var authState: OIDAuthState?
    static var email: String?

    /// Used the sign the user into their Google account for Gmail access.
    static func signIn(_ successHandler: @escaping () -> Void, _ errorHandler: @escaping (Error?) -> Void) {
        let appDelegate = NSApplication.shared.delegate as! AppDelegate
        let request = OIDAuthorizationRequest(
            configuration: configuration,
            clientId: clientID,
            clientSecret: nil,
            scopes: [OIDScopeOpenID, OIDScopeProfile, "https://mail.google.com/", "https://www.googleapis.com/auth/userinfo.email"],
            redirectURL: redirectURI,
            responseType: OIDResponseTypeCode,
            additionalParameters: nil
        )
        
        appDelegate.currentAuthorizationFlow = OIDAuthState.authState(
            byPresenting: request,
            externalUserAgent: OIDExternalUserAgentMac()
        ) { authState, error in
            if let authState = authState {
                self.authState = authState
                successHandler()
            } else {
                self.authState = nil
                errorHandler(error)
            }
        }
    }
    
    /// Gets the user's Google account information.
    ///
    /// - Note: this function sets the `email` property.
    static func getUserInfo() {
        authState?.performAction() { (accessToken, idToken, error) in
            if error != nil  {
                print("Error fetching fresh tokens: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            guard let accessToken = accessToken else {
                return
            }

            var urlRequest = URLRequest(url: URL(string: "https://www.googleapis.com/oauth2/v2/userinfo")!)
            urlRequest.allHTTPHeaderFields = ["Authorization": "Bearer \(accessToken)"]
            URLSession(configuration: .default).dataTask(with: urlRequest) { data, response, error in
                if let data = data,
                   let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any],
                   let email = json["email"] as? String {
                    self.email = email
                }
            }.resume()
        }
    }
}
