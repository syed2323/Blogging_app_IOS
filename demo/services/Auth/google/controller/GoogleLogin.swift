////
////  GoogleLogin.swift
////  demo
////
////  Created by Syed Abdul Ahad on 3/25/22.
////
//
import UIKit
import Firebase
import GoogleSignIn
import grpc
import Lottie

class GoogleLogin: UIViewController {
    var name = ""
    var email = ""
    
    //MARK: - animations
    
    @IBOutlet weak var lottieAnimations: AnimationView!
    //MARK: - google sign in button
    @IBOutlet weak var signInButton: GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animations()
    }
    
    
    //MARK: - animation calls
    func animations(){
        let animationsview = AnimationView(name: "59538-boy-working-on-laptop-lottie-animation")
        animationsview.frame = CGRect(x: 0, y: 20, width: 400, height: 500)
        view.addSubview(animationsview)
        animationsview.play()
        animationsview.loopMode = .loop
        
        
          
    }
    // MARK: - Google SignIn Process
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) {user, error in
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
          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: authentication.accessToken)

            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    print("Firebase Sign in error")
                    print(error)
                }else {
                          let storyboard = UIStoryboard(name: "googleLoginView", bundle: nil)
                          let detail:ViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                    print("user is sign in with Firebase")
                    self.navigationController?.pushViewController(detail, animated: true)
                }

            }
        }
        
    }
}
