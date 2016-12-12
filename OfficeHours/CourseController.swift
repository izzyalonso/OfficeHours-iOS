//
//  CourseController.swift
//  OfficeHours
//
//  Created by Ismael Alonso on 12/12/16.
//  Copyright © 2016 Tennessee Data Commons. All rights reserved.
//

import UIKit


class CourseController: UIViewController{
    
    var course: CourseModel!
    
    
    override func viewDidLoad(){
        navigationItem.title = course.getCode()
    }
}
