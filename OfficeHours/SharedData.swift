//
//  SharedData.swift
//  OfficeHours
//
//  Created by Ismael Alonso on 12/20/16.
//  Copyright © 2016 Tennessee Data Commons. All rights reserved.
//

import Foundation


class SharedData{
    private static var user: User?
    
    static func setUser(_ user: User){
        SharedData.user = user
    }
    
    static func getUser() -> User?{
        return user
    }
}
