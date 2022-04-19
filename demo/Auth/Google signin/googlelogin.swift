//
//  googlelogin.swift
//  demo
//
//  Created by Syed Abdul Ahad on 3/21/22.
//
import UIKit
import Firebase
import GoogleSignIn


class googlelogin: UIViewController {
   
    
   
    
var name = ""
var email = ""
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in

            if error != nil {
                    print("error occupied")
              return
          }

          guard
            let authentication = user?.authentication,
            let idToken = authentication.idToken
          else {
            return
          }

            _ = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: authentication.accessToken)

          // ...
        }
        
        
       
    }

    
    // MARK: - signin button
    
    @IBOutlet weak var SignInButton: GIDSignInButton!

    
}
