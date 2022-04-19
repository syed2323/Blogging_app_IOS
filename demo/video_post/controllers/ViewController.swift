//
//  ViewController.swift
//  demo
//
//  Created by syed abdul ahad on 03/02/2022.
//

import UIKit
import FirebaseDatabase
import CoreTelephony
import Kingfisher
import Lottie
import SwiftUI

class ViewController: UIViewController {

    var ref = Database.database().reference()
    
    @IBOutlet weak var tableView: UITableView!
    var usersData : [UserData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // add another page
        
        let animationsview = AnimationView(name: "loader")
        animationsview.frame = CGRect(x: 50, y: 250, width: 300, height: 300)
        view.addSubview(animationsview)
        animationsview.play()
        animationsview.loopMode = .loop
        
        
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        Servicess.GetData { data in
            animationsview.stop()
            animationsview.isHidden = true
            self.usersData = data
            print("USER DATA::::\(self.usersData)")
            self.tableView.reloadData()
        } onError: { error in
            debugPrint(error?.localizedDescription ?? "")
        }
    }
    
//    func loader_animation(){
//        let animationsview = AnimationView(name: "loader")
//        animationsview.frame = CGRect(x: 0, y: 20, width: 400, height: 500)
//        view.addSubview(animationsview)
//        animationsview.play()
//        animationsview.loopMode = .loop
//    }
    
}





extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.usersData.count   }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell
        
        cell?.cellUsersPost.text = usersData[indexPath.row].description_data
        cell?.cellUserPostDate.text = usersData[indexPath.row].uploading_date
        cell?.cellUserPostTime.text = usersData[indexPath.row].uploading_time
//        debugPrint("eeeeeeeeeeeeeeeeeeeeeeeee\(String(describing: usersData[indexPath.row].imageUrl))")
        let url = URL(string:usersData[indexPath.row].imageUrl ?? "")
        cell?.cellImage.kf.setImage(with: url)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 560
    }
    
    
}
