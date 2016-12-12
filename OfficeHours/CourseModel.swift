//
//  Course.swift
//  OfficeHours
//
//  Created by Ismael Alonso on 12/7/16.
//  Copyright © 2016 Tennessee Data Commons. All rights reserved.
//

import CoreData


class CourseModel{
    private var id: Int
    private var code: String
    private var name: String
    private var meetingTime: String
    private var lastMeetingDate: String
    private var accessCode: String
    private var instructorName: String
    
    
    convenience init(code: String, name: String, meetingTime: String, lastMeetingDate: String,
                     instructorName: String){
        self.init(id: -1, code: code, name: name, meetingTime: meetingTime,
             lastMeetingDate: lastMeetingDate, accessCode: "", instructorName: instructorName)
    }
    
    convenience init(course: NSManagedObject){
        self.init(
            id: course.value(forKey: "id") as! Int,
            code: course.value(forKey: "code") as! String,
            name: course.value(forKey: "name") as! String,
            meetingTime: course.value(forKey: "meetingTime") as! String,
            lastMeetingDate: course.value(forKey: "lastMeetingDate") as! String,
            accessCode: course.value(forKey: "accessCode") as! String,
            instructorName: course.value(forKey: "instructorName") as! String
        )
    }
    
    init(id: Int, code: String, name: String, meetingTime: String, lastMeetingDate: String,
         accessCode: String, instructorName: String){
        
        self.id = id
        self.code = code
        self.name = name
        self.meetingTime = meetingTime
        self.lastMeetingDate = lastMeetingDate
        self.accessCode = accessCode
        self.instructorName = instructorName
    }
    
    func getId() -> Int{
        return id
    }
    
    func getCode() -> String{
        return code
    }
    
    func getName() -> String{
        return name
    }
    
    func getDisplayName() -> String{
        return "\(code): \(name)"
    }
    
    func getMeetingTime() -> String{
        return meetingTime
    }
    
    func getLastMeetingDate() -> String{
        return lastMeetingDate
    }
    
    func getAccessCode() -> String{
        return accessCode
    }
    
    func getInstructorName() -> String{
        return instructorName
    }
}
