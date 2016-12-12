//
//  User.swift
//  OfficeHours
//
//  Created by Ismael Alonso on 12/8/16.
//  Copyright © 2016 Tennessee Data Commons. All rights reserved.
//


class User{
    private static let student = "Student"
    private static let instructor = "Instructor"
    
    
    //Things google give me
    private var email: String = ""
    private var googleToken: String = ""
    
    //Fields set during on boarding. Some of these are pre populated
    private var accountType: String? = User.student
    private var officeHours: [String] = [String]()
    private var firstName: String = ""
    private var lastName: String = ""
    private var schoolEmail: String = ""
    private var isOnBoardingComplete: Bool = false
    
    //Fields retrieved from the backend
    private var token: String = ""
    
    
    func isAccountTypeSet() -> Bool{
        return accountType == nil
    }
    
    func isStudent() -> Bool{
        return accountType == User.student
    }
    
    func isInstructor() -> Bool{
        return accountType == User.instructor
    }
}
