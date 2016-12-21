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
    
    @IBOutlet weak var accountTypeSelector: UISegmentedControl!
    
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
        
        firstName.layer.borderColor = UIColor.red.cgColor;
        firstName.layer.cornerRadius = 4;
        
        lastName.layer.borderColor = UIColor.red.cgColor;
        lastName.layer.cornerRadius = 4;
        
        schoolEmailAddress.layer.borderColor = UIColor.red.cgColor;
        schoolEmailAddress.layer.cornerRadius = 4;
        
        user = SharedData.getUser()!
        firstName.text = user.getFirstName()
        lastName.text = user.getLastName()
        emailAddress.text = user.getEmail()
        
        if user.isAccountTypeSet(){
            if user.isStudent(){
                accountTypeSelector.selectedSegmentIndex = 0
            }
            else if user.isInstructor(){
                accountTypeSelector.selectedSegmentIndex = 1
            }
        }
        else{
            for constraint in container.constraints{
                if constraint.belongsTo(view: personalInfoContainer){
                    personalInfoConstraints.append(constraint)
                }
            }
            personalInfoContainer.removeFromSuperview()
        }
        
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
            schoolEmailAddress.layer.borderWidth = 0
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
        scrollView.contentInset = UIEdgeInsets.zero
    }
    
    @IBAction func onDoneTapped(){
        let first = firstName.text!
        let last = lastName.text!
        let email = schoolEmailAddress.text!
        
        if first.isEmpty{
            firstName.layer.borderWidth = 1
            return
        }
        if last.isEmpty{
            lastName.layer.borderWidth = 1
            return
        }
        if !isValidEmail(email){
            schoolEmailAddress.layer.borderWidth = 1
            return
        }
        
        user.setName(first: first, last: last)
        user.set(schoolEmailAddress: email)
        user.set(phoneNumber: phoneNumber.text!)
        user.setOnBoardingComplete()
        user.writeToDefaults();
        
        let id = "MainNavController";
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: id)
        UIApplication.shared.keyWindow?.rootViewController = controller
    }
    
    private func isValidEmail(_ email: String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    @IBAction func onErrorCheckedFieldEditingDidBegin(_ sender: UITextField){
        if sender == firstName{
            firstName.layer.borderWidth = 0
        }
        else if sender == lastName{
            lastName.layer.borderWidth = 0
        }
        else if sender == schoolEmailAddress{
            schoolEmailAddress.layer.borderWidth = 0
        }
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
