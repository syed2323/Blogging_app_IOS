//
//  Utils.swift
//  demo
//
//  Created by Syed Abdul Ahad on 3/18/22.
//

import Foundation
import UIKit


class utils {
    
    //MARK: - keyboard enable/disable
    var isExpand : Bool = false
    @objc func keyboardApear(scrollView:UIScrollView){
        print("call")
        if !isExpand {
            scrollView.contentSize = CGSize(width: view.frame.width, height: self.scrollView.frame.height + 300)
            isExpand = true
        }
    }
    @objc func keyboardDisappear(scrollView:UIScrollView){
       
        if isExpand {
            scrollView.contentSize = CGSize(width: view.frame.width, height: self.scrollView.frame.height - 300)
            isExpand = false
        }
    }
}
