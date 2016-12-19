//
//  ViewController.swift
//  OfficeHours
//
//  Created by Ismael Alonso on 12/5/16.
//  Copyright © 2016 Tennessee Data Commons. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn


class LauncherController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate{
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().signOut()
        
        googleSignInButton.colorScheme = .dark
        googleSignInButton.style = .standard
        
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?){
        if let error = error{
            print(error.localizedDescription)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = FIRGoogleAuthProvider.credential(
            withIDToken: authentication.idToken,
            accessToken: authentication.accessToken
        )
        
        FIRAuth.auth()?.signIn(with: credential){ (user, error) in
            
        }
        
        // Perform any operations on signed in user here.
        let ooUser = User(user: user)
        ooUser.writeToDefaults()
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!, withError error: Error!){
    }
}
