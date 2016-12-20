//
//  OnBoardingController.swift
//  OfficeHours
//
//  Created by Ismael Alonso on 12/20/16.
//  Copyright © 2016 Tennessee Data Commons. All rights reserved.
//

import Foundation


class OnBoardingController: UIViewController{
    @IBOutlet weak var personalInfoContainer: UIView!
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var schoolEmailAddress: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    
    
    
    @IBAction func onTypeSelectorStateChanged(_ sender: UISegmentedControl){
        
    }
    
    @IBAction func onSchoolAddressSwitchStateChanged(_ sender: UISwitch){
        
    }
}
