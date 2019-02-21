//
//  KeyboardDismissExtension.swift
//  VolunteerHourTrackerV2
//
//
//

import Foundation
import UIKit
import UIKit.UIGestureRecognizerSubclass


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
