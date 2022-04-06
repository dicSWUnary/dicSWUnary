//
//  UsefulFuncs.swift
//  dicSWUnary
//
//  Created by JUEUN KIM on 2022/04/06.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(style: UIAlertController.Style, title: String, text: String) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: style)
        let success = UIAlertAction(title: "확인", style: .default)

        alert.addAction(success)
        
        self.present(alert, animated: true, completion: nil)
    }
}
