//
//  SettingsViewController.swift
//  SpeechTextTrial
//
//  Created by Emily Jewik on 2/21/19.
//  Copyright © 2019 Emily Jewik. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
//need cell for change color, male/female voice, make text bigger, attribution page, 
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1)
        
        let textView : UITextView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = textView.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 30)
        let trailingConstraint = textView.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: 30)
        let heightConstraint = textView.heightAnchor.constraint(equalToConstant: 400)
        leadingConstraint.isActive = true
        heightConstraint.isActive = true
        trailingConstraint.isActive = true
        
        let licenseString : String = "MIT License\nCopyright (c) 2016 AppCoda\nPermission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:\nThe above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.\nTHE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE."
        textView.text = licenseString
        
        
        
       
    }
    
   
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

}
