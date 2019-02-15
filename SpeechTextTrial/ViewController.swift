//
//  ViewController.swift
//  SpeechTextTrial
//
//  Created by Emily Jewik on 2/6/19.
//  Copyright © 2019 Emily Jewik. All rights reserved.
//

import UIKit

struct SpeechMessage {
    let text: String
    let isIncoming: Bool
}

class ViewController: UITableViewController {
    
    //if record button tapped isIncoming = true
    //if speak button tapped isIncoming = false
    
    fileprivate let cellId = "id"
    
    let speechMessages = [
         SpeechMessage(text: "Hello there I am testing right now", isIncoming: true),
         SpeechMessage(text: "Hello there I am testing right now. fdsjhafkdsfdsfdsfkafjdsflhdsfdfjdsfkhdflkdsfhdsjflhdsajfhdsjfhdsjkfdsjfasd", isIncoming: false),
         SpeechMessage(text: "Hello there I am testing right now", isIncoming: true),
        SpeechMessage(text: "Hello there I am testing right now", isIncoming: false),
        SpeechMessage(text: "Hello there I am testing right now", isIncoming: true),
        SpeechMessage(text: "Hello there I am testing right now", isIncoming: false),
        SpeechMessage(text: "Hello there I am testing right now", isIncoming: true),
        SpeechMessage(text: "Hello there I am testing right now", isIncoming: true)
        
        ]
    
    let speechInputContainerView : UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(speechInputContainerView)
        
        view.addConstraintsWithFormat("H: |[v0]|", views: speechInputContainerView)
        view.addConstraintsWithFormat("V:|[v0(48)]|)", views: speechInputContainerView)
        
        navigationItem.title = "Messages"
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.register(SpeechCell.self , forCellReuseIdentifier: cellId)
        //tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor( white: 0.98, alpha: 1 )
        
//        speechLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        //constraints
//        let constraints = [speechLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
//                           speechLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
//                           speechLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250)]
//
//        NSLayoutConstraint.activate(constraints)
//
//        leadingConstraint = speechLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
//        leadingConstraint.isActive = false
//
//        trailingConstraint = speechLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
//        trailingConstraint.isActive = true
        
//        let newView = UIView()
//        newView.backgroundColor = UIColor.red
//        view.addSubview(newView)
//
//        view.
//
//        newView.translatesAutoresizingMaskIntoConstraints = false
//        let horizontalConstraint = NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
//        let verticalConstraint = NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 300)
//        let widthConstraint = NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 300)
//        let heightConstraint = NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 50)
//        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
//        let toolbar = UIToolbar()
//        let flexibleBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
//        let textfield = UITextField()
//        let textfieldBarButton = UIBarButtonItem.init(customView: textfield)
//        // UIToolbar expects an array of UIBarButtonItems:
//        toolbar.items = [flexibleBarButton, textfieldBarButton, flexibleBarButton]
//        view.addSubview(toolbar)
        
        
    }
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return speechMessages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SpeechCell
//        cell.textLabel?.text = "little miss muffet sat on a tuffet eating her curds and whey she had a great fall and didn't get up and little miss muffet died in bed. when miss muffet had a tuffet "
   //     cell.textLabel?.numberOfLines = 0
        
        let speechMessage = speechMessages[indexPath.row]
        cell.speechLabel.text = speechMessage.text
//        cell.isIncoming = speechMessage.isIncoming
        
        cell.speechMessage = speechMessage
        
        //cell.isIncoming = true
//        cell.isIncoming = indexPath.row % 2 == 0
        
        return cell
    }

}

