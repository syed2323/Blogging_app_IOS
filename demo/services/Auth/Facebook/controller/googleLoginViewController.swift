//
//  googleLoginViewController.swift
//  demo
//
//  Created by Syed Abdul Ahad on 3/25/22.
//

import Foundation
import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth
import GoogleSignIn


class googleLoginViewController : UIViewController, GIDSignInDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    @IBOutlet weak var siginButton: GIDSignInButton!
    
    @IBAction func hello(_ sender: Any) {
        print("i'm pressed")
    }
    // MARK: - Google SignIn Process

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
      
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID )

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in

            if error != nil {
            // ...
            return
          }

          guard
            let authentication = user?.authentication,
            let idToken = authentication.idToken
          else {
            return
          }
            guard let authentication = user?.authentication else { return }
        let credential = GoogleAuthProvider.credential(
            withIDToken: idToken,
            accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print("Firebase Sign in error")
                print(error)
            }else {
//                      let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                      let detail:secondViewController = storyboard.instantiateViewController(withIdentifier: "secondViewController") as! secondViewController
                
//                if let name = authResult?.user.displayName{
//                    detail.l11 = name
//                }
//                if let profile = authResult?.additionalUserInfo{
//                    debugPrint(profile)
//                }
//                if let email = authResult?.user.email{
//                    detail.l22 = email
//                }
//                if let photo = authResult?.user.photoURL{
//                    print(photo)
//                    detail.l33 = photo
//                }
//                print("user is sign in with Firebase")
//                self.navigationController?.pushViewController(detail, animated: true)
            }

        }
    }
    }
}
