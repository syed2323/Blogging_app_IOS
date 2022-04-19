//
//  generalPost.swift
//  demo
//
//  Created by Syed Abdul Ahad on 2/12/22.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage


class generalPost: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
     
    
    
    @IBOutlet weak var submittButton: UIButton!
    @IBOutlet weak var image_loader: UIActivityIndicatorView!
    var ref = Database.database().reference()
    var imageurl : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        submittButton.isEnabled = false
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardApear), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    //MARK: - keyboard enable/disable
    var isExpand : Bool = false
    @objc func keyboardApear(){
        print("call")
        if !isExpand {
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height + 300)
            isExpand = true
        }
    }
    @objc func keyboardDisappear(){
        
        if isExpand {
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height - 300)
            isExpand = false
        }
    }
    
    
    //MARK: - scroll view
    @IBOutlet weak var scrollView: UIScrollView!
    //MARK: -image view
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: - uploadImage Button
    @IBAction func upload_button(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey:Any] )    {
        guard let image = info[.editedImage] as? UIImage else {return}
        if let url = info[UIImagePickerController.InfoKey.imageURL]as? URL{
            print(url)
            Servicess.complete(fileURL: url, submittButton: submittButton, image_loader: image_loader) { result in
                //                print(result)
                self.imageurl = result
                return result
            }
        }
        
        imageView.image = image
        dismiss(animated: true)
    }
    
    //MARK: - Discription
    
    @IBOutlet weak var Description: UITextField!
    

    
    
    //MARK: -UPLOAD TO FIREBASE //// submitt button
    
    @IBAction func Submiitt_to_firebase(_ sender: Any) {
        Servicess.PostData(imageurl: imageurl, Description: Description.text?.decomposedStringWithCanonicalMapping ?? "")
       
    }
}
