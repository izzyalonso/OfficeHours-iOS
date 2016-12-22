//
//  CourseEditorController.swift
//  OfficeHours
//
//  Created by Ismael Alonso on 12/21/16.
//  Copyright © 2016 Tennessee Data Commons. All rights reserved.
//

import Foundation


class CourseEditorController: UIViewController, TimeSlotPickerDelegate, DatePickerDelegate{
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var code: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var meetingTimeLabel: UILabel!
    @IBOutlet weak var lastMeetingDateLabel: UILabel!
    
    
    private let dateFormat = DateFormatter()
    
    private var meetingTime: String? = nil
    private var lastMeetingDate: Date? = nil
    
    
    var delegate: CourseEditorDelegate!
    var course: CourseModel?
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        code.layer.borderColor = UIColor.red.cgColor
        code.layer.cornerRadius = 4
        
        name.layer.borderColor = UIColor.red.cgColor
        name.layer.cornerRadius = 4
        
        dateFormat.dateFormat = "MMM d yyyy"
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: NSNotification.Name.UIKeyboardWillHide,
            object: nil
        )
    }
    
    func keyboardWillShow(notification: NSNotification){
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }
    
    func keyboardWillHide(notification: NSNotification){
        scrollView.contentInset = UIEdgeInsets.zero
    }
    
    @IBAction func pickMeetingTime(_ sender: Any){
        performSegue(withIdentifier: "TimeSlotPickerFromCourseEditor", sender: self)
    }
    
    @IBAction func pickDate(_ sender: Any){
        performSegue(withIdentifier: "DatePickerFromCourseEditor", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "TimeSlotPickerFromCourseEditor"{
            let slotPicker = segue.destination as! TimeSlotPickerController
            slotPicker.delegate = self
        }
        else if segue.identifier == "DatePickerFromCourseEditor"{
            let datePicker = segue.destination as! DatePickerController
            datePicker.delegate = self
        }
    }
    
    func onTimeSlotPicked(_ timeSlot: String){
        meetingTime = timeSlot
        meetingTimeLabel.text = timeSlot
    }
    
    func onDatePicked(_ date: Date){
        lastMeetingDate = date
        lastMeetingDateLabel.text = dateFormat.string(from: date)
    }
    
    @IBAction func onDoneTapped(){
        let codeStr = code.text!
        let nameStr = name.text!
        
        if codeStr.isEmpty{
            //code.layer.borderWidth = 1
            return
        }
        if nameStr.isEmpty{
            return
        }
        if meetingTime == nil{
            return
        }
        if lastMeetingDate == nil{
            return
        }
        
        if course == nil{
            course = CourseModel(code: codeStr, name: nameStr, meetingTime: meetingTime!, lastMeetingDate: lastMeetingDateLabel.text!, instructorName: SharedData.getUser()!.getName())
        }
        
        delegate.onCourseSaved(course!)
        navigationController!.popViewController(animated: true)
    }
}


extension CourseEditorController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if textField == code{
            name.becomeFirstResponder()
        }
        else if textField == name{
            name.resignFirstResponder()
        }
        return false
    }
}


protocol CourseEditorDelegate{
    func onCourseSaved(_ course: CourseModel)
}
