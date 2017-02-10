//
//  User.swift
//  OfficeHours
//
//  Created by Ismael Alonso on 12/8/16.
//  Copyright © 2016 Tennessee Data Commons. All rights reserved.
//

import ObjectMapper


class User: Base, CustomStringConvertible{
    private static let student = "Student"
    private static let instructor = "Instructor"
    
    
    //Things google give me
    private var photoUrl: String = ""
    private var email: String = ""
    
    //Fields set during on boarding. Some of these are pre populated
    private var accountType: String? = nil
    private var officeHours: [String] = [String]()
    private var firstName: String = ""
    private var lastName: String = ""
    private var schoolEmail: String = ""
    private var phoneNumber: String = ""
    private var needsOnBoardingInternal: Bool = false
    
    //Fields retrieved from the backend
    private var profileId: Int = 0;
    private var token: String = ""
    
    
    func setAsStudent(){
        accountType = User.student
    }
    
    func setAsInstructor(){
        accountType = User.instructor
    }
    
    func setName(first: String, last: String){
        firstName = first
        lastName = last
    }
    
    func set(schoolEmailAddress address: String){
        schoolEmail = address
    }
    
    func set(phoneNumber number: String){
        phoneNumber = number
    }
    
    func setOnBoardingComplete(){
        needsOnBoardingInternal = false
    }
    
    
    func getEmail() -> String{
        return email
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
    
    func getName() -> String{
        return "\(firstName) \(lastName)"
    }
    
    func getSchoolEmail() -> String{
        return schoolEmail
    }
    
    func getPhoneNumber() -> String{
        return phoneNumber
    }
    
    func needsOnBoarding() -> Bool{
        return needsOnBoardingInternal
    }
    
    
    func writeToDefaults(){
        let defaults = UserDefaults.standard
        defaults.set(getId(), forKey: "user.id")
        defaults.set(profileId, forKey: "user.profileId")
        defaults.set(email, forKey: "user.email")
        defaults.set(accountType, forKey: "user.accountType")
        defaults.set(firstName, forKey: "user.firstName")
        defaults.set(lastName, forKey: "user.lastName")
        defaults.set(schoolEmail, forKey: "user.schoolEmail")
        defaults.set(phoneNumber, forKey: "user.phoneNumber")
        defaults.set(needsOnBoardingInternal, forKey: "user.needsOnBoarding")
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
        super.init(id: defaults.object(forKey: "user.id") as! Int)
        profileId = defaults.object(forKey: "user.profileId") as! Int
        email = defaults.object(forKey: "user.email") as! String
        accountType = defaults.object(forKey: "user.accountType") as? String
        firstName = defaults.object(forKey: "user.firstName") as! String
        lastName = defaults.object(forKey: "user.lastName") as! String
        schoolEmail = defaults.object(forKey: "user.schoolEmail") as! String
        phoneNumber = defaults.object(forKey: "user.phoneNumber") as! String
        needsOnBoardingInternal = defaults.bool(forKey: "user.needsOnBoarding")
        token = defaults.object(forKey: "user.token") as! String
    }
    
    required init?(map: Map){
        super.init(map: map)
    }
    
    override func mapping(map: Map){
        super.mapping(map: map)
        profileId <- map["profile_id"]
        email <- map["email"]
        firstName <- map["first_name"]
        lastName <- map["last_name"]
        photoUrl <- map["google_image"]
        phoneNumber <- map["phone"]
        needsOnBoardingInternal <- map["needs_onboarding"]
        token <- map["token"]
    }
    
    func getHeaderMap() -> [String: String]{
        return ["Authorization": "Token \(token)"];
    }
    
    var description: String{
        let idSec = "(uid: \(getId()), pid: \(profileId))"
        let onBoardingSec = "\(needsOnBoardingInternal ? "needs" : "doesn't need") on-boarding"
        return "\(firstName) \(lastName) \(idSec), \(email), \(onBoardingSec)"
    }
}
