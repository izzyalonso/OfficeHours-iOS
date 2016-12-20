//
//  OnBoardingController.swift
//  OfficeHours
//
//  Created by Ismael Alonso on 12/20/16.
//  Copyright © 2016 Tennessee Data Commons. All rights reserved.
//

import Foundation


class OnBoardingController: UIViewController{
    @IBOutlet weak var container: UIView!
    @IBOutlet var personalInfoContainer: UIView!
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var schoolEmailAddress: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    
    
    private var personalInfoConstraints = [NSLayoutConstraint]()
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        for constraint in container.constraints{
            if constraint.belongsTo(view: personalInfoContainer){
                personalInfoConstraints.append(constraint)
            }
        }
        personalInfoContainer.removeFromSuperview()
        
        
    }
    
    
    @IBAction func onTypeSelectorStateChanged(_ sender: UISegmentedControl){
        if !personalInfoConstraints.isEmpty{
            container.addSubview(personalInfoContainer)
            for constraint in personalInfoConstraints{
                container.addConstraint(constraint)
            }
            personalInfoConstraints.removeAll()
        }
    }
    
    @IBAction func onSchoolAddressSwitchStateChanged(_ sender: UISwitch){
        
    }
}
