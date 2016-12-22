//
//  TimeRangePickerController.swift
//  OfficeHours
//
//  Created by Ismael Alonso on 12/22/16.
//  Copyright © 2016 Tennessee Data Commons. All rights reserved.
//

import Foundation


class TimeSlotPickerController: UIViewController, TimePickerDelegate{
    @IBOutlet weak var mSwitch: UISwitch!
    @IBOutlet weak var tSwitch: UISwitch!
    @IBOutlet weak var wSwitch: UISwitch!
    @IBOutlet weak var rSwitch: UISwitch!
    @IBOutlet weak var fSwitch: UISwitch!
    @IBOutlet weak var sSwitch: UISwitch!
    
    @IBOutlet weak var from: UILabel!
    @IBOutlet weak var to: UILabel!
    
    
    var delegate: TimeSlotPickerDelegate!
    var multiChoice = true
    
    private var fromSelected = false
    private var fromDate: Date?
    private var toDate: Date?
    private var timeFormatter = DateFormatter()
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        timeFormatter.dateFormat = "h:mm a"
    }
    
    @IBAction func onFromTapped(_ sender: Any){
        fromSelected = true
        performSegue(withIdentifier: "TimePickerFromSlotPicker", sender: self)
    }
    
    @IBAction func onToTapped(_ sender: Any){
        fromSelected = false
        performSegue(withIdentifier: "TimePickerFromSlotPicker", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "TimePickerFromSlotPicker"{
            let controller = segue.destination as! TimePickerController
            controller.delegate = self
            if fromSelected{
                controller.time = fromDate
            }
            else{
                controller.time = toDate
            }
        }
    }
    
    func onTimePicked(_ time: Date){
        if fromSelected{
            fromDate = time
            from.text = "From \(timeFormatter.string(for: time)!)"
        }
        else{
            toDate = time
            to.text = "To \(timeFormatter.string(for: time)!)"
        }
    }
    
    @IBAction func onDoneTapped(){
        var result = ""
        if mSwitch.isOn{
            result += "M"
        }
        if tSwitch.isOn{
            result += "T"
        }
        if wSwitch.isOn{
            result += "W"
        }
        if rSwitch.isOn{
            result += "R"
        }
        if fSwitch.isOn{
            result += "F"
        }
        if sSwitch.isOn{
            result += "S"
        }
        
        if !result.isEmpty && fromDate != nil && toDate != nil{
            let fromStr = timeFormatter.string(for: fromDate!)!
            let toStr = timeFormatter.string(for: toDate!)!
            result += " \(fromStr) - \(toStr)"
            
            delegate.onTimeSlotPicked(result)
            navigationController!.popViewController(animated: true)
        }
    }
}

protocol TimeSlotPickerDelegate{
    func onTimeSlotPicked(_ timeSlot: String)
}
