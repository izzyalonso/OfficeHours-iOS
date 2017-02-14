//
//  Message.swift
//  OfficeHours
//
//  Created by Ismael Alonso on 2/13/17.
//  Copyright © 2017 Tennessee Data Commons. All rights reserved.
//

import ObjectMapper


class Message: Base{
    private var senderId: Int = -1
    private var recipientId: Int = -1
    private var text: String = ""
    private var read: Bool = false
    //private var createdOn: String = ""
    
    private var timestamp: TimeInterval = -1
    private var isSent: Bool = false
    
    
    func getSenderId() -> Int{
        return senderId
    }
    
    func getRecipientId() -> Int{
        return recipientId
    }
    
    func getText() -> String{
        return text
    }
    
    func isRead() -> Bool{
        return read
    }
    
    func getTimestamp() -> TimeInterval{
        return timestamp
    }
    
    override func mapping(map: Map){
        super.mapping(map: map)
        senderId <- map["user"]
        text <- map["text"]
        read <- map["read"]
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSZ"
        var createdOn = ""
        createdOn <- map["created_on"]
        timestamp = formatter.date(from: createdOn)!.timeIntervalSince1970
        
        isSent = true
    }
}


class MessageList: Mappable{
    var messages: [Message] = []
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        messages <- map["results"]
    }
}
