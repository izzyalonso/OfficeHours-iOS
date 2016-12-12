//
//  AddCourseController.swift
//  OfficeHours
//
//  Created by Ismael Alonso on 12/8/16.
//  Copyright © 2016 Tennessee Data Commons. All rights reserved.
//

import UIKit


class AddCourseController: UIViewController{
    @IBOutlet weak var code1: UITextField!
    @IBOutlet weak var code2: UITextField!
    @IBOutlet weak var code3: UITextField!
    @IBOutlet weak var code4: UITextField!
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var courseContainer: UIView!
    
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var courseMeetingTime: UILabel!
    @IBOutlet weak var courseLastMeetingDate: UILabel!
    @IBOutlet weak var courseInstructor: UILabel!
    
    var delegate: AddCourseDelegate!
    var course: CourseModel!
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        code1.addTarget(self, action: #selector(AddCourseController.codeValueChanged(_:)), for: UIControlEvents.editingChanged)
        code2.addTarget(self, action: #selector(AddCourseController.codeValueChanged(_:)), for: UIControlEvents.editingChanged)
        code3.addTarget(self, action: #selector(AddCourseController.codeValueChanged(_:)), for: UIControlEvents.editingChanged)
        code4.addTarget(self, action: #selector(AddCourseController.codeValueChanged(_:)), for: UIControlEvents.editingChanged)
        
        code1.becomeFirstResponder()
    }
    
    func codeValueChanged(_ sender: UITextField){
        if sender == code1{
            if code1.text?.characters.count == 1{
                code2.becomeFirstResponder()
            }
        }
        else if sender == code2{
            if code2.text?.characters.count == 1{
                code3.becomeFirstResponder()
            }
        }
        else if sender == code3{
            if code3.text?.characters.count == 1{
                code4.becomeFirstResponder()
            }
        }
        else if sender == code4{
            if code4.text?.characters.count == 1{
                code4.resignFirstResponder()
                
                code1.isEnabled = false
                code2.isEnabled = false
                code3.isEnabled = false
                code4.isEnabled = false
                activity.isHidden = false
                errorLabel.isHidden = true
                
                let code = "\(code1.text!)\(code2.text!)\(code3.text!)\(code4.text!)"
                print(code)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    if code == "1234"{
                        self.errorLabel.isHidden = true
                        self.activity.isHidden = true
                        self.courseContainer.isHidden = false
                        
                        let course = CourseModel(code: "COMP 1900", name: "Intro to CS", meetingTime: "MW 7", lastMeetingDate: "12/14", instructorName: "Someboody")
                        
                        self.setCourse(course: course)
                    }
                    else{
                        self.errorLabel.isHidden = false
                        self.activity.isHidden = true
                        self.code1.text = ""
                        self.code2.text = ""
                        self.code3.text = ""
                        self.code4.text = ""
                        self.code1.isEnabled = true
                        self.code2.isEnabled = true
                        self.code3.isEnabled = true
                        self.code4.isEnabled = true
                        self.code1.becomeFirstResponder()
                    }
                }
            }
        }
    }
    
    func setCourse(course: CourseModel){
        self.course = course;
        
        courseName.text = course.getDisplayName()
        courseMeetingTime.text = course.getMeetingTime()
        courseLastMeetingDate.text = course.getLastMeetingDate()
        courseInstructor.text = course.getInstructorName()
    }
    
    @IBAction func addCourse(){
        self.delegate.onCourseAdded(course: course)
        _ = self.navigationController?.popViewController(animated: true)
    }
}

extension AddCourseController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        return (textField.text?.characters.count)! < 1 && string.characters.count < 2
    }
}


protocol AddCourseDelegate{
    func onCourseAdded(course: CourseModel)
}
