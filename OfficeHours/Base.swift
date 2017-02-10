//
//  Base.swift
//  OfficeHours
//
//  Created by Ismael Alonso on 2/9/17.
//  Copyright © 2017 Tennessee Data Commons. All rights reserved.
//

import Foundation


import ObjectMapper


class Base: Mappable{
    private var id: Int = -1;
    
    
    init(id: Int){
        self.id = id;
    }
    
    func getId() -> Int{
        return id;
    }
    
    func getType() -> String{
        return "";
    }
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map){
        id <- map["id"];
    }
}
