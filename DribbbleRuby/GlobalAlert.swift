//
//  GlobalAlert.swift
//  DribbbleRuby
//
//  Created by Valerii Korobov on 05.06.17.
//  Copyright © 2017 Valerii Korobov. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    //MARK: Global Alert Message
    func alertMessage(title: String, alertMessage: String, buttonTitle: String, action: @escaping (() -> Void)) {
        let myAlert = UIAlertController(title:title, message:alertMessage, preferredStyle: UIAlertControllerStyle.alert);
        let okAction = UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.default) {
            UIAlertAction in
            action()
        }
        myAlert.addAction(okAction)
        
        self.present(myAlert, animated: true, completion: nil);
    }
}
