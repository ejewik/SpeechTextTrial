//
//  SpeechCell.swift
//  SpeechTextTrial
//
//  Created by Emily Jewik on 2/6/19.
//  Copyright © 2019 Emily Jewik. All rights reserved.
//

import UIKit

class SpeechCell: UITableViewCell {

   let speechLabel = UILabel()
    
    //need to set all constraints with relation to the superview...
    
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    var topConstraint: NSLayoutConstraint!
    var bottomConstraint: NSLayoutConstraint!
    
    var speechMessage: SpeechMessage! {
        didSet {
            speechLabel.textColor = speechMessage.isIncoming ? .black : UIColor(red: 18/255.0, green: 150/255.0, blue: 255/255.0, alpha: 1 )
            
            
             //speechLabel.text = speechLabel.text
            
//            ViewController.transition(with: speechLabel,
//                              duration: 0.25,
//                              options: [.transitionCrossDissolve],
//                              animations: {
//                                speechLabel.text = speechLabel.text
//            }, completion: nil)
            
             speechLabel.font = UIFont(name: "PingFang HK", size: 20)
            
            
//            speechLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
//            speechLabel.transform = CGAffineTransform( scaleX: -1,y: 1)
//
//            speechLabel.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0)
            
            if speechMessage.isIncoming { // gray
                leadingConstraint.isActive = true
                trailingConstraint.isActive = false
            }
            else { // blue
                leadingConstraint.isActive = false
                trailingConstraint.isActive = true
            }
        }
    }
    
//    var isIncoming: Bool! {
//        didSet {
//            speechLabel.textColor = isIncoming ? .darkGray : .blue
//        }
//    }
    
    //puts message label in cell
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        addSubview(speechLabel)
       

        speechLabel.numberOfLines = 0
        
        speechLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //constraints
        topConstraint = speechLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16)
        topConstraint.identifier = "topConstraint"
        topConstraint.isActive = true
        
        bottomConstraint = speechLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        bottomConstraint.identifier = "bottomConstraint"
        bottomConstraint.isActive = true
        
        let widthConstraint = speechLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250)
        widthConstraint.identifier = "widthConstraint"
        widthConstraint.priority = UILayoutPriority(rawValue: 999)
        NSLayoutConstraint.activate([widthConstraint])
        
        
        leadingConstraint = speechLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        leadingConstraint.identifier = "leadingConstraint"
        leadingConstraint.isActive = false
        
        trailingConstraint = speechLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        trailingConstraint.identifier = "trailingConstraint"
        trailingConstraint.isActive = true
        
        
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
