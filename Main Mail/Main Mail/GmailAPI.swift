//
//  GmailAPI.swift
//  Main Mail
//
//  Created by Elijah Sawyers on 1/25/21.
//

import Foundation

class GmailAPI {
    /// The email to use throughout all Gmail API calls.
    var email: String?
    
    /// Gets the user's Google account information.
    ///
    /// - Note: this function sets the `email` property.
    func getUserInfo() {
        GoogleOAuth.authState?.performAction() { [unowned self] (accessToken, idToken, error) in
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
