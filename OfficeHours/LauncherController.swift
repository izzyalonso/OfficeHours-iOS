//
//  ViewController.swift
//  OfficeHours
//
//  Created by Ismael Alonso on 12/5/16.
//  Copyright © 2016 Tennessee Data Commons. All rights reserved.
//

import UIKit
import GoogleSignIn

import Just
import ObjectMapper


class LauncherController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate{
    
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().signOut()
        
        googleSignInButton.colorScheme = .dark
        googleSignInButton.style = .standard
        
        print("I am getting here")
        
        GIDSignIn.sharedInstance().clientID = "152170900684-nvq12vbfasvbta3h90rd4o30ditbms2c.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
        /*let user = User.readFromDefaults()
        if let user = user{
            SharedData.setUser(user)
            if user.needsOnBoarding(){
                transitionToOnBoarding()
            }
            else{
                transitionToSchedule()
            }
        }*/
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?){
        if let error = error{
            print(error.localizedDescription)
            return
        }
        
        print(API.BODY.signIn(user: user))
        Just.post(API.URL.signIn(), json: API.BODY.signIn(user: user)){ (response) in
            print(response.statusCode ?? "No status code")
            if response.ok{
                let user = User(JSONString: response.contentStr)!
                print(user)
            }
            else{
                print(response.content ?? "No content");
                print(response.contentStr);
                print("request failed")
                print(response.error ?? "No error")
            }
        }
        
        // Perform any operations on signed in user here.
        //let ooUser = User(user: user)
        //ooUser.writeToDefaults()
        //SharedData.setUser(ooUser)
        
        ///transitionToOnBoarding()
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user:GIDGoogleUser!, withError error: Error!){
        
    }
    
    func transitionToOnBoarding(){
        let id = "OnBoardingNavController";
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: id)
        UIApplication.shared.keyWindow?.rootViewController = controller
    }
    
    func transitionToSchedule(){
        let id = "MainNavController";
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: id)
        UIApplication.shared.keyWindow?.rootViewController = controller
    }
}
