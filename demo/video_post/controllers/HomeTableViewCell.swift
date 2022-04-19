//
//  TableViewCell.swift
//  demo
//
//  Created by syed abdul ahad on 03/02/2022.
//

import UIKit
import Firebase
import FirebaseDatabase


class HomeTableViewCell: UITableViewCell {
    
 
    @IBOutlet weak var tableCellContainer: UIView!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellUsersPost: UILabel!
    //    @IBOutlet weak var cellUserId: UILabel!
    @IBOutlet weak var cellUserPostTime: UILabel!
    @IBOutlet weak var cellUserPostDate: UILabel!

}
