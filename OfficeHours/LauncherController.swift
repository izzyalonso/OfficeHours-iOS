//
//  ViewController.swift
//  OfficeHours
//
//  Created by Ismael Alonso on 12/5/16.
//  Copyright © 2016 Tennessee Data Commons. All rights reserved.
//

import UIKit

class LauncherController: UIViewController{
    override func viewDidLoad(){
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = mainStoryboard.instantiateViewController(withIdentifier: "MainNavController")
            UIApplication.shared.keyWindow?.rootViewController = viewController
        }
    }
}
