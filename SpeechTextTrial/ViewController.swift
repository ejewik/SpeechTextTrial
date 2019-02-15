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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var tableView : UITableView!
    
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
    
//    let bottomView : UIView = {
//        let bottomView = UIView()
//        bottomView.backgroundColor = .red
//        bottomView.translatesAutoresizingMaskIntoConstraints = false
//        return bottomView
//    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view.addSubview(speechInputContainerView)
        

        navigationItem.title = "Messages"
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 500.0, height: 500.0))
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        let bottomView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        bottomView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bottomView.backgroundColor = .red
        self.view.addSubview(bottomView)
        //bottomView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        //bottomView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        //bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        self.view.bringSubviewToFront(bottomView)
        
        bottomView.layer.zPosition = 1
        
        
      
        
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
        
        tableView.register(SpeechCell.self , forCellReuseIdentifier: cellId)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.view.addSubview(tableView)
        
       
        //tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor( white: 0.98, alpha: 1 )
        

//        let toolbar = UIToolbar()
//        let flexibleBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
//        let textfield = UITextField()
//        let textfieldBarButton = UIBarButtonItem.init(customView: textfield)
//        // UIToolbar expects an array of UIBarButtonItems:
//        toolbar.items = [flexibleBarButton, textfieldBarButton, flexibleBarButton]
//        view.addSubview(toolbar)
        
        
    }
    
    
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return speechMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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

