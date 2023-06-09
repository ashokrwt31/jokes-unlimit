//
//  UIAlertController.swift
//  JokeList
//
//  Created by Ashok Rawat on 09/06/23.
//

import UIKit

extension UIAlertController {
    
    static func showAlert(title: String?, message: String?, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
    }
}
