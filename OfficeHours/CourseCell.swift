//
//  CourseCell.swift
//  OfficeHours
//
//  Created by Ismael Alonso on 12/7/16.
//  Copyright © 2016 Tennessee Data Commons. All rights reserved.
//

import UIKit


class CourseCell: UITableViewCell{
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!


    func bind(course: CourseModel){
        name.text = course.getName()
        time.text = course.getMeetingTime()
    }
}
