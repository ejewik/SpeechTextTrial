//
//  ViewController.swift
//  SpeechTextTrial
//
//  Created by Emily Jewik on 2/6/19.
//  Copyright © 2019 Emily Jewik. All rights reserved.
//

import UIKit
import Speech

struct SpeechMessage {
    var text: String
    var isIncoming: Bool
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SFSpeechRecognizerDelegate {
    
    //why are constraints not working for speechcell??
    private var tableView : UITableView!
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    private let recordButton : UIButton = UIButton()
    private let speakButton : UIButton = UIButton()
    private var speechAssign = SpeechMessage(text: "", isIncoming: false)
    private let speechField : UITextField = UITextField()
    private var recordImage : UIImage = UIImage()
    
    var utterance : AVSpeechUtterance?
    
    
    let synth = AVSpeechSynthesizer()
    
    
   // var cell : SpeechCell = SpeechCell()
    
    
    //if record button tapped isIncoming = true
    //if speak button tapped isIncoming = false
    
    fileprivate let cellId = "id"
    
    var speechMessages : [SpeechMessage] = []
    
//    let bottomView : UIView = {
//        let bottomView = UIView()
//        bottomView.backgroundColor = .red
//        bottomView.translatesAutoresizingMaskIntoConstraints = false
//        return bottomView
//    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
       
        
        
        
        
        //recordButton = UIButton()
        recordButton.addTarget(self, action: #selector(recordButtonTapped(sender:)), for: .touchUpInside)
        
        speakButton.addTarget(self, action: #selector(speakButtonTapped(sender:)), for: .touchUpInside)
        
        
        let settingsButton = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(settingsButtonTapped(sender:)))
        
        self.navigationItem.rightBarButtonItem = settingsButton
        self.navigationItem.rightBarButtonItem?.tintColor = .white
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        self.hideKeyboardWhenTappedAround()
 
        navigationItem.title = ""
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor(red: 0/255.0, green: 122/255.0, blue: 255/255.0, alpha: 1)
        
        
        
        //initialize tableview and add constraints
 
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(tableView)
        
        
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        //tableView.layer.zPosition = 3
        
        //initialize bottom view and set constraints
        
        let bottomView : UIView = UIView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(bottomView)
        
        let leadingViewConstraint = bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailingViewConstraint = bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let bottomViewConstraint = bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        //let widthViewConstraint = bottomView.widthAnchor.constraint(equalToConstant: 400)
        let heightViewConstraint = bottomView.heightAnchor.constraint(equalToConstant: 40)
        
        leadingViewConstraint.isActive = true
        trailingViewConstraint.isActive = true
        //widthViewConstraint.isActive = true
        heightViewConstraint.isActive = true
        bottomViewConstraint.isActive = true
        
        bottomView.layer.zPosition = 2
        bottomView.backgroundColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1)
        //initialize speech text field and set constraints
        
        utterance?.voice = AVSpeechSynthesisVoice(language: "en-US")
        speechField.translatesAutoresizingMaskIntoConstraints = false
        speechField.placeholder = "   Enter text here"
        speechField.font = UIFont.systemFont(ofSize: 17)
        speechField.keyboardType = .default
        speechField.returnKeyType = .default
        speechField.clearButtonMode = .whileEditing
        speechField.isUserInteractionEnabled = true
        speechField.translatesAutoresizingMaskIntoConstraints = false
        speechField.backgroundColor = .white
        speechField.delegate = self
        
        bottomView.addSubview(speechField)
        
   
        
        let leadingFieldConstraint = speechField.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 12)
        let trailingFieldConstraint = speechField.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -90)
        let bottomFieldConstraint = speechField.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -5)
       // let widthFieldConstraint = speechField.widthAnchor.constraint(equalToConstant: 250)
        let heightFieldConstraint = speechField.heightAnchor.constraint(equalToConstant: 30)
        
       
        
        leadingFieldConstraint.isActive = true
        trailingFieldConstraint.isActive = true
        bottomFieldConstraint.isActive = true
        //widthFieldConstraint.isActive = true
        heightFieldConstraint.isActive = true
        
        speechField.layer.zPosition = 1
        speechField.borderStyle = .roundedRect
        speechField.layer.cornerRadius = 15.0
        
      
        
        
        
        tableView.register(SpeechCell.self , forCellReuseIdentifier: cellId)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = UIColor( white: 0.98, alpha: 1 )
        
        
        
        recordButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        bottomView.addSubview(recordButton)
        
        recordImage = UIImage(named: "Microphone Icon.png")!
        
        recordButton.setImage(recordImage , for: .normal)
        
        let leadingButtonConstraint = recordButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 340)
        //let trailingButtonConstraint = recordButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -5)
        let widthButtonConstraint = recordButton.widthAnchor.constraint(equalToConstant: 30)
        let bottomButtonConstraint = recordButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -5)
        let heightButtonConstraint = recordButton.heightAnchor.constraint(equalToConstant: 30)
        
        leadingButtonConstraint.isActive = true
        //trailingButtonConstraint.isActive = true
        bottomButtonConstraint.isActive = true
        heightButtonConstraint.isActive = true
        widthButtonConstraint.isActive = true
        
        speakButton.translatesAutoresizingMaskIntoConstraints = false
        speakButton.backgroundColor = .red
        bottomView.addSubview(speakButton)
        
        let leadingSpeakButtonConstraint = speakButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 290)
        //let trailingSpeakButtonConstraint = recordButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -50)
        let bottomSpeakButtonConstraint = speakButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -5)
        let heightSpeakButtonConstraint = speakButton.heightAnchor.constraint(equalToConstant: 30)
        let widthSpeakButtonConstraint = speakButton.widthAnchor.constraint(equalToConstant: 30)

        leadingSpeakButtonConstraint.isActive = true
        //trailingSpeakButtonConstraint.isActive = true
        bottomSpeakButtonConstraint.isActive = true
        heightSpeakButtonConstraint.isActive = true
        widthSpeakButtonConstraint.isActive = true
        
        //tableView.transform = CGAffineTransform (scaleX: 1,y: -1);

        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        tableView.reloadData()
        recordButton.isEnabled = false
        speechRecognizer.delegate = self
        
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            
            var isButtonEnabled = false
            
            switch authStatus {
            case .authorized:
                isButtonEnabled = true
                
            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")
                
            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")
                
            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }
            
            OperationQueue.main.addOperation() {
                self.recordButton.isEnabled = isButtonEnabled
            }
        }
        
       
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        tableView.estimatedRowHeight = 100
//        tableView.rowHeight = UITableView.automaticDimension
//    }
    
//    func handleTap(gestureRecognizer: UITapGestureRecognizer) {
//        print("In handler")
//    }
    
    
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return speechMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SpeechCell
        
        //transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi));
        
        let speechMessage = speechMessages[indexPath.row]
        
        //try for fade in effect later on
        
        cell.speechLabel.text = speechMessage.text
//        cell.isIncoming = speechMessage.isIncoming
        
        cell.speechMessage = speechMessage
        
        //cell.isIncoming = true
//        cell.isIncoming = indexPath.row % 2 == 0
        
        //cell.contentView.transform = CGAffineTransform (scaleX: 1,y: -1);
        
        return cell
    }
    
//    func updateTableContentInset() {
//        let numRows = tableView(self.tableView, numberOfRowsInSection: 0)
//        var contentInsetTop = self.tableView.bounds.size.height
//        for i in 0..<numRows {
//            let rowRect = self.tableView.rectForRow(at: IndexPath(item: i, section: 0))
//            contentInsetTop -= rowRect.size.height
//            if contentInsetTop <= 0 {
//                contentInsetTop = 0
//            }
//        }
//        self.tableView.contentInset = UIEdgeInsets(top: contentInsetTop, left: 0, bottom: 0, right: 0)
//    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc func settingsButtonTapped(sender: UIButton!) {
        print("Settings button tapped")
        
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "nextView") as! NextViewController
//        self.present(nextViewController, animated:true, completion:nil)
        
        let settingsViewController : SettingsViewController = SettingsViewController()
        self.navigationController!.pushViewController(settingsViewController, animated: true)
    }
    
    @objc func recordButtonTapped(sender: UIButton!) {
        print("Record button tapped")
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            recordButton.isEnabled = false
            speakButton.isEnabled = false
            //speakButton.isEnabled = false
            
        } else {
            speakButton.isEnabled = false
            speechAssign = SpeechMessage(text: "", isIncoming: true)
            self.speechMessages.append(speechAssign)
          
            startRecording(speech: speechAssign)
            
            
            
        }
    }
    
    //maybe append "       " speechMessage to last cell to move up view???
    
    @objc func speakButtonTapped(sender: UIButton!) {
        print("speakButtonTapped")
        print(speakButton.isEnabled)
        synth.stopSpeaking(at: .immediate)
        if speakButton.isEnabled == true {
            utterance = AVSpeechUtterance(string: speechField.text!)
            synth.speak(utterance!)
            //messages.append(Message(message: speakField.text!, sender: "sender"))
            speechMessages.append(SpeechMessage(text: speechField.text!, isIncoming: false))
            speechField.text = ""
            //self.tableView.cellForRow(at: IndexPath(row: self.messages.count-1, section: 0))?.textLabel?.text = speakField.text
            getTableViewData()
            //view.accessibilityScroll(direction: )
        }
    }
    
    func startRecording(speech: SpeechMessage) {
    
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.measurement)
            //play and record??
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            var isFinal = false
            
            if result != nil {
                //self.tableView.cellForRow(at: IndexPath(row: self.speechMessages.count - 1, section: 0))?.textLabel?.text = result?.bestTranscription.formattedString
                //self.tableView.cellForRow(at: IndexPath(row: self.speechMessages.count - 1, section: 0))?.
                //self.speechMessages.append(self.speechAssign)
                //self.speechAssign.isIncoming = false
                //self.tableView.cellForRow(at: IndexPath(row: self.speechMessages.count - 1, section: 0))?.speechLabel.text = result?.bestTranscription.formattedString
                //self.speechAssign.text = result?.bestTranscription.formattedString ?? ""
                //self.cell.speechLabel.text = result?.bestTranscription.formattedString ?? ""
                self.tableView.reloadData()
                
                //if result?.bestTranscription.formattedString != nil {
                
                self.speechMessages[self.speechMessages.count - 1].text = result?.bestTranscription.formattedString ?? ""
                
                
                    
                   // self.speechMessages.removeLast()
                    
                    
               // }
                
                
                //if result?.bestTranscription.formattedString == nil {
                //    print( "this is\(result?.bestTranscription.formattedString)")
                //    self.speechMessages.removeLast()
                //}
                
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                
                
                self.recordButton.isEnabled = true
                self.speakButton.isEnabled = true
            
            }
        } )
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
            
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
            }  catch {
                    print("audioengine could not start: error")
                }
                
        
        
    }
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            recordButton.isEnabled = true
        } else {
            recordButton.isEnabled = false
        }
    }
    
    func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func getTableViewData(){
        tableView.reloadData()
        
        tableView.scrollToBottom()
    }


    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

extension UITableView {
    
    func scrollToBottom() {
        let rows = self.numberOfRows(inSection: 0)
        
        let indexPath = IndexPath(row: rows - 1, section: 0)
        self.scrollToRow(at: indexPath, at: .top, animated: true)
       
    }
}





extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // return NO to disallow editing.
        print("TextField should begin editing method called")
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // became first responder
        print("TextField did begin editing method called")
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
        print("TextField should snd editing method called")
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
        print("TextField did end editing method called")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        // if implemented, called in place of textFieldDidEndEditing:
        print("TextField did end editing with reason method called")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // return NO to not change text
        print("While entering the characters this method gets called")
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // called when clear button pressed. return NO to ignore (no notifications)
        print("TextField should clear method called")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // called when 'return' key pressed. return NO to ignore.
        print("TextField should return method called")
        // may be useful: textField.resignFirstResponder()
        return true
    }
    
}

