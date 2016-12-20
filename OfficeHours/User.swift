//
//  User.swift
//  OfficeHours
//
//  Created by Ismael Alonso on 12/8/16.
//  Copyright © 2016 Tennessee Data Commons. All rights reserved.
//

//import Foundation


class User{
    private static let student = "Student"
    private static let instructor = "Instructor"
    
    
    //Things google give me
    private var email: String = ""
    private var googleToken: String = ""
    
    //Fields set during on boarding. Some of these are pre populated
    private var accountType: String? = nil
    private var officeHours: [String] = [String]()
    private var firstName: String = ""
    private var lastName: String = ""
    private var schoolEmail: String = ""
    private var phoneNumber: String = ""
    private var isOnBoardingComplete: Bool = false
    
    //Fields retrieved from the backend
    private var token: String = ""
    
    
    init(user: GIDGoogleUser){
        email = user.profile.email
        googleToken = user.authentication.idToken
        
        firstName = user.profile.givenName
        lastName = user.profile.familyName
        schoolEmail = email
    }
    
    
    func setAsStudent(){
        accountType = User.student
    }
    
    func setAsInstructor(){
        accountType = User.instructor
    }
    
    
    func getEmail() -> String{
        return email
    }
    
    func getGoogleToken() -> String{
        return googleToken
    }
    
    func isAccountTypeSet() -> Bool{
        return accountType != nil
    }
    
    func isStudent() -> Bool{
        return accountType == User.student
    }
    
    func isInstructor() -> Bool{
        return accountType == User.instructor
    }
    
    func getFirstName() -> String{
        return firstName
    }
    
    func getLastName() -> String{
        return lastName
    }
    
    func getSchoolEmail() -> String{
        return schoolEmail
    }
    
    func getPhoneNumber() -> String{
        return phoneNumber
    }
    
    func needsOnBoarding() -> Bool{
        return !isOnBoardingComplete
    }
    
    
    func writeToDefaults(){
        let defaults = UserDefaults.standard
        defaults.set(email, forKey: "user.email")
        defaults.set(googleToken, forKey: "user.googleToken")
        defaults.set(accountType, forKey: "user.accountType")
        defaults.set(firstName, forKey: "user.firstName")
        defaults.set(lastName, forKey: "user.lastName")
        defaults.set(schoolEmail, forKey: "user.schoolEmail")
        defaults.set(phoneNumber, forKey: "user.phoneNumber")
        defaults.set(isOnBoardingComplete, forKey: "user.isOnBoardingComplete")
        defaults.set(token, forKey: "user.token")
    }
    
    func deleteFromDefaults(){
        
    }
    
    static func readFromDefaults() -> User?{
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "user.email") == nil{
            return nil
        }
        return User(defaults)
    }
    
    private init(_ defaults: UserDefaults){
        email = defaults.object(forKey: "user.email") as! String
        googleToken = defaults.object(forKey: "user.googleToken") as! String
        accountType = defaults.object(forKey: "user.accountType") as? String
        firstName = defaults.object(forKey: "user.firstName") as! String
        lastName = defaults.object(forKey: "user.lastName") as! String
        schoolEmail = defaults.object(forKey: "user.schoolEmail") as! String
        phoneNumber = defaults.object(forKey: "user.phoneNumber") as! String
        isOnBoardingComplete = defaults.bool(forKey: "user.isOnBoardingComplete")
        token = defaults.object(forKey: "user.token") as! String
    }
}
