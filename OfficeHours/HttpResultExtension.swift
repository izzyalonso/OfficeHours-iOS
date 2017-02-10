//
//  HttpResultExtension.swift
//  OfficeHours
//
//  Created by Ismael Alonso on 2/9/17.
//  Copyright © 2017 Tennessee Data Commons. All rights reserved.
//

import Foundation
import Just


extension Just.HTTPResult{
    var contentStr: String{
        get{
            return String(data: content!, encoding:.utf8) as String!;
        }
    }
}
