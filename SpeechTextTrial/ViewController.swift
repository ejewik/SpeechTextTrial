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
    let text: String
    let isIncoming: Bool
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SFSpeechRecognizerDelegate {
    
    private var tableView : UITableView!
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    private let recordButton : UIButton = UIButton()
    
    
    
    //if record button tapped isIncoming = true
    //if speak button tapped isIncoming = false
    
    fileprivate let cellId = "id"
    
    var speechMessages = [
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
        
        
        
        
        
        
        
        
        
        //recordButton = UIButton()
        recordButton.addTarget(self, action: #selector(recordButtonTapped(sender:)), for: .touchUpInside)
        
        
        let settingsButton = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(settingsButtonTapped(sender:)))
        
        self.navigationItem.rightBarButtonItem = settingsButton
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        self.hideKeyboardWhenTappedAround()
 
        navigationItem.title = ""
        navigationController?.navigationBar.prefersLargeTitles = true
        
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
        bottomView.backgroundColor = .gray
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
        
        //initialize speech text field and set constraints
        
        let speechField : UITextField = UITextField()
        speechField.translatesAutoresizingMaskIntoConstraints = false
        speechField.placeholder = "Enter text here"
        speechField.font = UIFont.systemFont(ofSize: 15)
        speechField.keyboardType = .default
        speechField.returnKeyType = .done
        speechField.clearButtonMode = .whileEditing
        speechField.isUserInteractionEnabled = true
        speechField.translatesAutoresizingMaskIntoConstraints = false
        speechField.backgroundColor = .white
        speechField.delegate = self
        
        bottomView.addSubview(speechField)
        
   
        
        let leadingFieldConstraint = speechField.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 12)
        let trailingFieldConstraint = speechField.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -25)
        let bottomFieldConstraint = speechField.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -5)
       // let widthFieldConstraint = speechField.widthAnchor.constraint(equalToConstant: 250)
        let heightFieldConstraint = speechField.heightAnchor.constraint(equalToConstant: 30)
        
       
        
        leadingFieldConstraint.isActive = true
        trailingFieldConstraint.isActive = true
        bottomFieldConstraint.isActive = true
        //widthFieldConstraint.isActive = true
        heightFieldConstraint.isActive = true
        
        speechField.layer.zPosition = 1
        
        speechField.layer.cornerRadius = 15.0
        
      
        print(speechField.bounds)
        print(bottomView.bounds)
        
        
        tableView.register(SpeechCell.self , forCellReuseIdentifier: cellId)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = UIColor( white: 0.98, alpha: 1 )
        
        
        
        recordButton.translatesAutoresizingMaskIntoConstraints = false
        recordButton.backgroundColor = .blue
        bottomView.addSubview(recordButton)
        
        let leadingButtonConstraint = recordButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 100)
        let trailingButtonConstraint = recordButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: 0)
        let bottomButtonConstraint = recordButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -5)
        let heightButtonConstraint = recordButton.heightAnchor.constraint(equalToConstant: 30)
        
        leadingButtonConstraint.isActive = true
        trailingButtonConstraint.isActive = true
        bottomButtonConstraint.isActive = true
        heightButtonConstraint.isActive = true
        
        
        
        
        
        
        
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
    
//    func handleTap(gestureRecognizer: UITapGestureRecognizer) {
//        print("In handler")
//    }
    
    
    
    

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
    }
    
    @objc func recordButtonTapped(sender: UIButton!) {
        print("Record button tapped")
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            recordButton.isEnabled = false
            //speakButton.isEnabled = false
            
        } else {
            //speakButton.isEnabled = false
            let speech = SpeechMessage(text: "message", isIncoming: false)
            self.speechMessages.append(speech)
            startRecording(speech: speech)
            
            
        }
    }
    
    func startRecording(speech: SpeechMessage) {
    
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.record, mode: AVAudioSession.Mode.measurement)
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
                self.tableView.cellForRow(at: IndexPath(row: self.speechMessages.count - 1, section: 0))?.textLabel?.text = result?.bestTranscription.formattedString
                self.tableView.reloadData()
                
                //speech._speech = result?.bestTranscription.formattedString
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.recordButton.isEnabled = true
            
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

