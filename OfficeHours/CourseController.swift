//
//  CourseController.swift
//  OfficeHours
//
//  Created by Ismael Alonso on 12/12/16.
//  Copyright © 2016 Tennessee Data Commons. All rights reserved.
//

import UIKit


class CourseController: UIViewController{
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var meetingTime: UILabel!
    @IBOutlet weak var lastMeetingDate: UILabel!
    @IBOutlet weak var instructorName: UILabel!
    
    
    var course: CourseModel!
    
    
    override func viewDidLoad(){
        navigationItem.title = course.getCode()
        name.text = course.getName()
        meetingTime.text = course.getMeetingTime()
        lastMeetingDate.text = course.getLastMeetingDate()
        instructorName.text = course.getInstructorName()
    }
}
