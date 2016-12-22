//
//  TimePickerController.swift
//  OfficeHours
//
//  Created by Ismael Alonso on 12/22/16.
//  Copyright © 2016 Tennessee Data Commons. All rights reserved.
//

import Foundation


class TimePickerController: UIViewController{
    @IBOutlet weak var timePicker: UIDatePicker!
    
    
    var delegate: TimePickerDelegate!
    var time: Date?
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        if let time = time{
            timePicker.setDate(time, animated: false)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool){
        delegate.onTimePicked(timePicker.date)
        super.viewWillDisappear(animated)
    }
}

protocol TimePickerDelegate{
    func onTimePicked(_ time: Date)
}
