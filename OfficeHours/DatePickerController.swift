//
//  DatePickerController.swift
//  OfficeHours
//
//  Created by Ismael Alonso on 12/21/16.
//  Copyright © 2016 Tennessee Data Commons. All rights reserved.
//

import Foundation


class DatePickerController: UIViewController{
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    var delegate: DatePickerDelegate!
    var date: Date?
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        datePicker.minimumDate = Date()
        if let date = date{
            datePicker.setDate(date, animated: false)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool){
        delegate.onDatePicked(datePicker.date)
        super.viewWillDisappear(animated)
    }
}

protocol DatePickerDelegate{
    func onDatePicked(_ date: Date)
}
