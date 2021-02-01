//
//  GmailAPI.swift
//  Main Mail
//
//  Created by Elijah Sawyers on 1/25/21.
//

import Foundation
import Alamofire

class GmailAPI {
    /*
     * MARK: - Type alias
     */

    typealias Success = (Any) -> Void
    typealias Error = (AFError) -> Void
    
    /*
     * MARK: - Public types[s]
     */
    
    enum RESTResource {
        case messages(after: Date? = nil)
        case message(id: String)
    }
    
    private struct RESTResourceURL {
        private(set) var url: String
        
        private init(_ url: String) {
            self.url = url
        }
        
        private static func baseURL(with userId: String) -> String {
            "https://gmail.googleapis.com/gmail/v1/users/{userId}"
                .replacingOccurrences(of: "{userId}", with: userId)
        }
        
        static func messages(with userId: String, after date: Date?) -> RESTResourceURL {
            var query = ""
            if date != nil {
                let seconds = Int(date!.timeIntervalSince1970)
                query = "?q=after:\(seconds)"
            }
            return RESTResourceURL(baseURL(with: userId) + "/messages\(query)")
        }

        static func message(with userId: String, id: String) -> RESTResourceURL {
            RESTResourceURL(baseURL(with: userId) + "/messages/\(id)")
        }
    }
    
    /*
     * MARK: - Private(set) instance variable[s]
     */

    /// Name of the authenticated Google user, if applicable.
    ///
    /// - Note: If the user isn't authenticated through `GoogleOAuth`, the value nil.
    private(set) var name: String?

    /// Email of the authenticated Google user, if applicable.
    ///
    /// - Note: This is the email used through all Gmail API calls.
    ///         If the user isn't authenticated through `GoogleOAuth`, the value nil.
    private(set) var email: String?
    
    /// Whether or not the `GmailAPI` instance is configured and ready for Gmail API calls.
    private(set) var isConfigured: Bool = false
    
    /*
     * MARK: - Initializer[s]
     */
    
    /// Creates a new instance of the `GmailAPI` using the user authenticated with `GoogleOAuth`.
    init(successHandler: Success? = nil, errorHandler: Error? = nil) {
        request(
            url: "https://www.googleapis.com/oauth2/v2/userinfo",
            successHandler: { [unowned self] data in
                if let data = data as? [String:Any] {
                    self.name = data["name"] as? String
                    self.email = data["email"] as? String
                    self.isConfigured = true
                    successHandler?(data)
                }
            }, errorHandler: { error in
                print("Error creating instance of GmailAPI: \(error.localizedDescription))")
                errorHandler?(error)
            })
    }
    
    /*
     * MARK: - Private instance method[s]
     */
    
    /// Wraps an Alamofire request in the `performAction` method of `AppAuth` to ensure a fresh access token.
    private func request(url: String, successHandler: Success? = nil, errorHandler: Error? = nil) {
        GoogleOAuth.authState?.performAction() { accessToken, idToken, error in
            if error != nil  {
                print("Error fetching fresh tokens: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            guard let accessToken = accessToken else {
                return
            }

            AF.request(url, headers: ["Authorization": "Bearer \(accessToken)"]).responseJSON { response in
                switch response.result {
                case .success(let data):
                    successHandler?(data)
                case .failure(let error):
                    errorHandler?(error)
                }
            }
        }
    }
    
    /*
     * MARK: - Public instance method[s]
     */

    func get(
        resource: RESTResource,
        successHandler: Success? = nil,
        errorHandler: Error? = nil
    ) {
        if let email = email {
            // Build the request URL.
            var restResourceUrl: RESTResourceURL
            switch resource {
            case .messages(let date):
                restResourceUrl = RESTResourceURL.messages(with: email, after: date)
            case .message(let id):
                restResourceUrl = RESTResourceURL.message(with: email, id: id)
            }
            
            // Make the request.
            request(
                url: restResourceUrl.url,
                successHandler: successHandler,
                errorHandler: errorHandler
            )
        }
    }
}
