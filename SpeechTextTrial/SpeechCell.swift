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
            speechLabel.textColor = speechMessage.isIncoming ? .darkGray : .blue
            
            
            speechLabel.text = speechLabel.text
            
            if speechMessage.isIncoming {
                leadingConstraint.isActive = true
                trailingConstraint.isActive = false
            }
            else {
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
        topConstraint.isActive = true
        
        bottomConstraint = speechLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        bottomConstraint.isActive = true
        
        let widthConstraint = speechLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250)
        
        NSLayoutConstraint.activate([widthConstraint])
        
        leadingConstraint = speechLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        leadingConstraint.isActive = false
        
        trailingConstraint = speechLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        trailingConstraint.isActive = true
        
        
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
