//
//  NSLayoutConstraintExtension.swift
//  OfficeHours
//
//  Created by Ismael Alonso on 12/20/16.
//  Copyright © 2016 Tennessee Data Commons. All rights reserved.
//

extension NSLayoutConstraint{
    func belongsTo(view: UIView) -> Bool{
        return firstItem === view || secondItem === view
    }
}
