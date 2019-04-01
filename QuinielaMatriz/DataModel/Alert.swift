//
//  Alert.swift
//  QuinielaMatriz
//
//  Created by User on 4/1/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

struct Alert {
    
    private static func showBasicAlert(on vc: UIViewController, with title: String, message: String) {
        // Declare Alert message
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // Create button
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        // Present dialog message to user in the main thread
        DispatchQueue.main.async {
            vc.present(alert, animated: true)
        }
    }
    
    static func showAlertWithActions(on vc: UIViewController, with actionTitle: String, message: String, action: @escaping (UIAlertAction) -> Void) {
        // Declare Alert message
        let dialogMessage = UIAlertController(title: "Confirm", message: message, preferredStyle: .alert)
        
        // Create button with action handler
        let customButton = UIAlertAction(title: actionTitle, style: .destructive, handler: action)
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
        }
        
        //Add Custom and Cancel button to dialog message
        dialogMessage.addAction(customButton)
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user in the main thread
        DispatchQueue.main.async {
            vc.present(dialogMessage, animated: true, completion: nil)
        }
    }
}
