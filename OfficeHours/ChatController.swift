//
//  ChatController.swift
//  OfficeHours
//
//  Created by Ismael Alonso on 2/13/17.
//  Copyright © 2017 Tennessee Data Commons. All rights reserved.
//

import UIKit
import Just
import ObjectMapper


class ChatController: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [Message] = [Message]()
    
    
    override func viewDidLoad(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:sZ"
        
        SharedData.setUser(User())
        
        let url = API.URL.chatHistory(user1: 121, user2: 1, before: formatter.string(from: Date()))
        Just.get(url, headers: SharedData.getUser()!.getHeaderMap()) { (response) in
            print(response.contentStr)
            if response.ok{
                self.messages = Mapper<MessageList>().map(JSONString: response.contentStr)!.messages
                
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            }
        }
    }
}


extension ChatController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as! MessageCell
        cell.setMessage(message: messages[indexPath.row])
        return cell
    }
}
