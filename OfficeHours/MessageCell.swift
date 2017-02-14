//
//  MessageCell.swift
//  OfficeHours
//
//  Created by Ismael Alonso on 2/13/17.
//  Copyright © 2017 Tennessee Data Commons. All rights reserved.
//

import UIKit


class MessageCell: UITableViewCell{
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var state: UIImageView!
    
    func setMessage(message: Message){
        self.message.text = message.getText()
    }
}
