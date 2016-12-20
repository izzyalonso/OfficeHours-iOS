//
//  OnBoardingController.swift
//  OfficeHours
//
//  Created by Ismael Alonso on 12/20/16.
//  Copyright © 2016 Tennessee Data Commons. All rights reserved.
//

import UIKit


class OnBoardingController: UIViewController{
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var container: UIView!
    @IBOutlet var personalInfoContainer: UIView!
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var schoolEmailAddress: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    
    private var personalInfoConstraints = [NSLayoutConstraint]()
    
    
    private var user: User!
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        for constraint in container.constraints{
            if constraint.belongsTo(view: personalInfoContainer){
                personalInfoConstraints.append(constraint)
            }
        }
        personalInfoContainer.removeFromSuperview()
        
        user = SharedData.getUser()!
        firstName.text = user.getFirstName()
        lastName.text = user.getLastName()
        emailAddress.text = user.getEmail()
        
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
    
    @IBAction func onTypeSelectorStateChanged(_ sender: UISegmentedControl){
        if !personalInfoConstraints.isEmpty{
            container.addSubview(personalInfoContainer)
            for constraint in personalInfoConstraints{
                container.addConstraint(constraint)
            }
            personalInfoConstraints.removeAll()
        }
        
        if sender.selectedSegmentIndex == 0{
            //Student
            user.setAsStudent()
        }
        else if sender.selectedSegmentIndex == 1{
            //Instructor
            user.setAsInstructor()
        }
        user.writeToDefaults()
    }
    
    @IBAction func onSchoolAddressSwitchStateChanged(_ sender: UISwitch){
        schoolEmailAddress.isEnabled = !sender.isOn
        if sender.isOn{
            schoolEmailAddress.text = user.getEmail()
            if schoolEmailAddress.isFirstResponder{
                schoolEmailAddress.resignFirstResponder()
            }
        }
        else{
            schoolEmailAddress.text = ""
        }
    }
    
    func keyboardWillShow(notification: NSNotification){
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        self.scrollView.contentInset = contentInset
    }
    
    func keyboardWillHide(notification: NSNotification){
        scrollView.contentInset = UIEdgeInsets.zero;
    }
}


extension OnBoardingController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if textField == firstName{
            lastName.becomeFirstResponder()
        }
        else if textField == lastName{
            if schoolEmailAddress.isEnabled{
                schoolEmailAddress.becomeFirstResponder()
            }
            else{
                phoneNumber.becomeFirstResponder()
            }
        }
        else if textField == schoolEmailAddress{
            phoneNumber.becomeFirstResponder()
        }
        else if textField == phoneNumber{
            phoneNumber.resignFirstResponder()
        }
        return false
    }
}
