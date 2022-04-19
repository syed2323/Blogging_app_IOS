//
//  fetching_post_data.swift
//  demo
//
//  Created by Syed Abdul Ahad on 3/16/22.
//

import Foundation
import Firebase
import FirebaseDatabase
import UIKit
import SwiftUI

struct UserData:Codable{
    var imageUrl:String?=nil
    var uploading_date:String!
    var uploading_time:String!
    var description_data:String!
    
    enum CodingKeys :String,CodingKey{
        
        case imageUrl = "imageUrl"
        case uploading_date = "uploading_date"
        case uploading_time = "uploading_time"
        case description_data = "description_data"
        
    }
}

class Servicess{
    
    
    
    // MARK: - upload image on firebase storage
    
    static func complete(fileURL : URL, submittButton: UIButton, image_loader : UIActivityIndicatorView, completion: @escaping (_ result : String) -> String){
        submittButton.isEnabled = false
        image_loader.startAnimating()
        let storage = Storage.storage()
        _ = Data()
        let stoargeRef = storage.reference()
        let localfile = fileURL
        let uniqueImageId = UUID.init()
        let phototRef = stoargeRef.child(uniqueImageId.uuidString)
        // Upload the file to the path "images/rivers.jpg"
        phototRef.putFile(from: localfile, metadata: nil,completion: { (metadata, error) in
            if error != nil {
                print("❗️failed to upload video")
            }else{
                guard let metadata = metadata else {
                    print("error occured")
                    return
                }
                _ = metadata.size
                phototRef.downloadURL { (url, error) in
                    guard let downloadURL = url else{return}
                    image_loader.stopAnimating()
                    submittButton.isEnabled = true
                    print("Downloaded image url ::::::::::::::: ")
                    print(downloadURL)
                    let image_url = (downloadURL.relativeString)
                    completion(image_url)
                    print("now printing data  inside image_url :::::")
                    //                    print(image_url)
                    //                    status = true
                }
            }
            
        })
    }
    
    
    //MARK: - Post data to firebase
    static func PostData(imageurl : String, Description: String){
        let ref = Database.database().reference()
        
    
        
        // Get uploading time
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy HH:mm:ss"
        let dateString = df.string(from: date)
        let fulllDateArr = dateString.components(separatedBy: " ")
        let date_    = fulllDateArr[0]
        let time = fulllDateArr[1]
        //unique id
        let uniqueId = UUID.init()
        
        
        // uploading to database
        ref.child("Users").child(uniqueId.uuidString).setValue(
            [
                "ImageUrl" : imageurl,
                "Discription" : Description,
                "Uploading_time" : time,
                "Uploading_date" : date_
            ]
            
        )
        
    }
    
    
    
    //MARK: - Get data from firebase
    static func GetData(onSuccess: @escaping(_ data:[UserData]) -> Void, onError: @escaping(_ error: Error?)-> Void)
    {
        var data_list:[UserData] = []
        let refer = Database.database().reference()
        _ = UserDefaults.standard
        refer.child("Users").observe(. value) { (snapshot) in
            //get user value
            let value = snapshot.value as? [String : AnyObject] ?? [:]
            
            
            for (index,item) in value.enumerated(){
                debugPrint(index)
                debugPrint(item)
                let dict = (item.value as! [String:Any])
                if let imageUrl = dict["ImageUrl"] as? String, let discription = dict["Discription"] as? String, let uploading_time = dict["Uploading_time"] as? String, let uploading_date = dict["Uploading_date"] as? String{
                    let data = UserData(imageUrl: imageUrl, uploading_date: uploading_date, uploading_time: uploading_time, description_data: discription)
                    data_list.append(data)
                }
            }
            debugPrint(data_list)
            print("printing length of data :::::::::::::::::::::::::::")
            debugPrint(data_list.count)
            onSuccess(data_list)
            
        } withCancel: { Error in
            
            onError(Error)
            print("error is found")
        }
    }
    
}

