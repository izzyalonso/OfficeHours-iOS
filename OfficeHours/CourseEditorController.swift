//
//  CourseEditorController.swift
//  OfficeHours
//
//  Created by Ismael Alonso on 12/21/16.
//  Copyright © 2016 Tennessee Data Commons. All rights reserved.
//

import Foundation


class CourseEditorController: UIViewController, TimeSlotPickerDelegate, DatePickerDelegate{
    
    @IBOutlet weak var meetingTimeLabel: UILabel!
    @IBOutlet weak var lastMeetingDateLabel: UILabel!
    
    
    private let dateFormat = DateFormatter()
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        dateFormat.dateFormat = "MMM d yyyy"
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
        meetingTimeLabel.text = timeSlot
    }
    
    func onDatePicked(_ date: Date){
        lastMeetingDateLabel.text = dateFormat.string(from: date)
    }
}
