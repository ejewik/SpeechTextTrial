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
    public let voiceSwitch : UISwitch = UISwitch(frame: CGRect(x: 10, y: 10, width: 100, height: 20))
    let sizeLabel : UILabel = UILabel(frame: CGRect(x: 10, y: 10, width: 100, height: 20))
    let maleLabel : UILabel = UILabel(frame: CGRect(x: 10, y: 10, width: 100, height: 20))
    let femaleLabel : UILabel = UILabel(frame: CGRect(x: 10, y: 10, width: 100, height: 20))
    let voiceLabel : UILabel = UILabel(frame: CGRect(x: 10, y: 10, width: 100, height: 20))
    let aLabel : UILabel = UILabel(frame: CGRect(x: 10, y: 10, width: 100, height: 20))
    let ALabel : UILabel = UILabel(frame: CGRect(x: 10, y: 10, width: 100, height: 20))
    
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
        
        sizeLabel.text = "Text Size"
        sizeLabel.font = UIFont(name: "PingFang HK", size: 14)
        sizeLabel.textColor = .gray
        
        //sizeSlider "a" label
        
        aLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(aLabel)
        
        let aLabelLeading = aLabel.leadingAnchor.constraint(equalTo: sizeSlider.leadingAnchor, constant: -15)
        let aLabelWidth = aLabel.widthAnchor.constraint(equalToConstant: 20)
        let aLabelTop = aLabel.topAnchor.constraint(equalTo: sizeSlider.topAnchor , constant: 0)
        let aLabelHeight = aLabel.heightAnchor.constraint(equalToConstant: 20)
        
        aLabelLeading.isActive = true
        aLabelWidth.isActive = true
        aLabelTop.isActive = true
        aLabelHeight.isActive = true
        
        aLabel.text = "A"
        aLabel.font = UIFont(name: "PingFang HK", size: 15)
        aLabel.textColor = .gray
        
        
        //sizeSlider "A" label
        
        ALabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(ALabel)
        
        let ALabelLeading = ALabel.leadingAnchor.constraint(equalTo: sizeSlider.trailingAnchor, constant: 10)
        let ALabelWidth = ALabel.widthAnchor.constraint(equalToConstant: 20)
        let ALabelTop = ALabel.topAnchor.constraint(equalTo: sizeSlider.topAnchor , constant: -3)
        let ALabelHeight = ALabel.heightAnchor.constraint(equalToConstant: 27)
        
        ALabelLeading.isActive = true
        ALabelWidth.isActive = true
        ALabelTop.isActive = true
        ALabelHeight.isActive = true
        
        ALabel.text = "A"
        ALabel.font = UIFont(name: "PingFang HK", size: 30)
        ALabel.textColor = .gray
        
        
        
        //male/Female voice switch
        
        voiceSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(voiceSwitch)
        
        let voiceSwitchLeading = voiceSwitch.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (UIScreen.main.bounds.width / 2.0) - 20)
        let voiceSwitchTop = voiceSwitch.topAnchor.constraint(equalTo: sizeSlider.topAnchor, constant: 100)
        let voiceSwitchHeight = voiceSwitch.heightAnchor.constraint(equalToConstant: 50)
        let voiceSwitchWidth = voiceSwitch.widthAnchor.constraint(equalToConstant: 50)
        
        voiceSwitchLeading.isActive = true
        voiceSwitchTop.isActive = true
        voiceSwitchHeight.isActive = true
        voiceSwitchWidth.isActive = true
        
        voiceSwitch.onTintColor = .blue
        
        //male/Female voice male label
        
        maleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(maleLabel)
        
        let maleLabelLeading = maleLabel.leadingAnchor.constraint(equalTo: voiceSwitch.leadingAnchor, constant: -50)
        let maleLabelTop = maleLabel.topAnchor.constraint(equalTo: voiceSwitch.topAnchor, constant: 0)
        let maleLabelHeight = maleLabel.heightAnchor.constraint(equalToConstant: 20)
        let maleLabelWidth = maleLabel.widthAnchor.constraint(equalToConstant: 50)
        
        maleLabelLeading.isActive = true
        maleLabelTop.isActive = true
        maleLabelHeight.isActive = true
        maleLabelWidth.isActive = true
        
        maleLabel.text = "Male"
        maleLabel.font = UIFont(name: "PingFang HK", size: 14)
        maleLabel.textColor = .gray
        
        //male/Female voice female label
        
        femaleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(femaleLabel)
        
        let femaleLabelLeading = femaleLabel.leadingAnchor.constraint(equalTo: voiceSwitch.leadingAnchor, constant: 70)
        let femaleLabelTop = femaleLabel.topAnchor.constraint(equalTo: voiceSwitch.topAnchor, constant: 0)
        let femaleLabelHeight = femaleLabel.heightAnchor.constraint(equalToConstant: 20)
        let femaleLabelWidth = femaleLabel.widthAnchor.constraint(equalToConstant: 50)
        
        femaleLabelLeading.isActive = true
        femaleLabelTop.isActive = true
        femaleLabelHeight.isActive = true
        femaleLabelWidth.isActive = true
        
        femaleLabel.text = "Female"
        femaleLabel.font = UIFont(name: "PingFang HK", size: 14)
        femaleLabel.textColor = .gray
        
        //voiceLabel
        
        voiceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(voiceLabel)
        
        let voiceLabelLeading = voiceLabel.leadingAnchor.constraint(equalTo: sizeSlider.leadingAnchor, constant: 0)
        let voiceLabelWidth = voiceLabel.widthAnchor.constraint(equalToConstant: 100)
        let voiceLabelTop = voiceLabel.topAnchor.constraint(equalTo: voiceSwitch.topAnchor , constant: -40)
        let voiceLabelHeight = voiceLabel.heightAnchor.constraint(equalToConstant: 20)
        
        voiceLabelLeading.isActive = true
        voiceLabelWidth.isActive = true
        voiceLabelTop.isActive = true
        voiceLabelHeight.isActive = true
        
        voiceLabel.text = "Voice"
        voiceLabel.font = UIFont(name: "PingFang HK", size: 14)
        voiceLabel.textColor = .gray
        
        
        
      
        
        
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
