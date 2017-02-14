//
//  API.swift
//  OfficeHours
//
//  Created by Ismael Alonso on 2/8/17.
//  Copyright © 2017 Tennessee Data Commons. All rights reserved.
//

import Foundation


class API{
    static let staging = true
    private static let useNgrokTunnel = false
    private static let appApiUrl = "https://app.tndata.org/api/"
    private static let stagingApiUrl = "https://staging.tndata.org/api/"
    private static let ngrokTunnelUrl = "https://tndata.ngrok.io/api/"
    
    private static let apiUrl =
        useNgrokTunnel ?
            ngrokTunnelUrl
            :
            staging ?
                stagingApiUrl
                :
                appApiUrl
    
    
    class URL{
       class func signIn() -> String{
            return "\(apiUrl)users/oauth/"
        }
        
        class func chatHistory(user1: Int, user2: Int, before timestamp: String) -> String{
            let first = user1 < user2 ? user1 : user2
            let second = user1 > user2 ? user1 : user2
            let room = "room=chat-\(first)-\(second)"
            let time = "before=\(timestamp.replacingOccurrences(of: " ", with: "%20"))"
            return "\(apiUrl)chat/history/?\(room)&\(time)"
        }
    }
    
    
    class BODY{
        class func signIn(user: GIDGoogleUser) -> [String: String]{
            var body = [String: String]()
            body["email"] = user.profile.email
            body["first_name"] = user.profile.givenName
            body["last_name"] = user.profile.familyName
            body["image_url"] = user.profile.imageURL(withDimension: 100).absoluteString
            body["oauth_token"] = user.authentication.idToken
            return body
        }
    }
}
