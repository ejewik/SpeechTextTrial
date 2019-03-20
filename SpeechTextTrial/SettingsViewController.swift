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
    
    public let sizeSlider : UISlider = UISlider(frame: CGRect(x: 10, y: 10, width: 100, height: 20))
    let sizeLabel : UILabel = UILabel(frame: CGRect(x: 10, y: 10, width: 100, height: 20))
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1)
        
        
        
        
        
        //sizeSlider
        
        sizeSlider.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(sizeSlider)
        
        let sizeLeadingConstraint = sizeSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 75)
        let sizeTrailingConstraint = sizeSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -75)
        let sizeHeightConstraint = sizeSlider.heightAnchor.constraint(equalToConstant: 20)
        let sizeTopConstraint = sizeSlider.topAnchor.constraint(equalTo: view.topAnchor, constant: 150)
        
        sizeLeadingConstraint.isActive = true
        sizeTrailingConstraint.isActive = true
        sizeHeightConstraint.isActive = true
        sizeTopConstraint.isActive = true
        
        sizeSlider.minimumValue = 0.0;
        sizeSlider.maximumValue = 100.0;
        sizeSlider.value = 50;
        sizeSlider.isContinuous = true;
        sizeSlider.isEnabled = true;
        sizeSlider.thumbTintColor = .blue
        
        //sizeSliderLabel
        
        sizeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(sizeLabel)
        
        let sizeLabelLeading = sizeLabel.leadingAnchor.constraint(equalTo: sizeSlider.leadingAnchor, constant: 0)
        let sizeLabelWidth = sizeLabel.widthAnchor.constraint(equalToConstant: 100)
        let sizeLabelTop = sizeLabel.topAnchor.constraint(equalTo: sizeSlider.topAnchor , constant: -40)
        let sizeLabelHeight = sizeLabel.heightAnchor.constraint(equalToConstant: 20)
        
        sizeLabelLeading.isActive = true
        sizeLabelWidth.isActive = true
        sizeLabelTop.isActive = true
        sizeLabelHeight.isActive = true
        
        sizeLabel.text = "TEXT SIZE"
        sizeLabel.font = UIFont(name: "PingFang HK", size: 12)
        sizeLabel.textColor = .gray
        
        
      
        
        
        //let textView : UITextView = UITextView(frame: CGRect(x: UIScreen.main.bounds.width / 10.0, y: 100, width: 200, height: 400))
        //textView.backgroundColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1)
        //textView.isEditable = false
        //textView.font = UIFont(name: "PingFang HK", size: 15)

        //self.view.addSubview(textView)
        
        //let licenseString : String = "MIT License\nCopyright (c) 2016 AppCoda\nPermission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:\nThe above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.\nTHE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE."
        //textView.text = licenseString
        
        
        
        
        
        
       
    }
    
   
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

}
