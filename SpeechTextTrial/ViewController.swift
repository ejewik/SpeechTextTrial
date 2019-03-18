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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SFSpeechRecognizerDelegate, AVSpeechSynthesizerDelegate {
    
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
    private var bottomView : UIView = UIView()
    private var blueMicrophoneImage : UIImage = UIImage()
    private var arrowImage : UIImage = UIImage()
    var cellHeightsDictionary: [IndexPath: CGFloat] = [:]
    
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
        
        synth.delegate = self
        
        
       
        
        blueMicrophoneImage = UIImage(named: "Microphone Icon Blue.png")!
        arrowImage = UIImage(named: "Arrow Icon.png")!
        
        //recordButton = UIButton()
        recordButton.addTarget(self, action: #selector(recordButtonTapped(sender:)), for: .touchUpInside)
        
        speakButton.addTarget(self, action: #selector(speakButtonTapped(sender:)), for: .touchUpInside)
        
        
        let settingsButton = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(settingsButtonTapped(sender:)))
        settingsButton.tintColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1)
        
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
        navigationController?.navigationBar.barTintColor = UIColor(red: 57/255.0, green: 125/255.0, blue: 220/255.0, alpha: 1)
        
        
        
        //initialize tableview and add constraints
 
//        tableView = UITableView()
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//
//
//        view.addSubview(tableView)
//
//
//        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
//        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
//        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: 0).isActive = true
        
        //tableView.layer.zPosition = 3
        
        //initialize bottom view and set constraints
        
        bottomView = UIView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(bottomView)
        
        let leadingViewConstraint = bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailingViewConstraint = bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let bottomViewConstraint = bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        //let widthViewConstraint = bottomView.widthAnchor.constraint(equalToConstant: 400)
        let heightViewConstraint = bottomView.heightAnchor.constraint(equalToConstant: 60)
        
        leadingViewConstraint.isActive = true
        trailingViewConstraint.isActive = true
        //widthViewConstraint.isActive = true
        heightViewConstraint.isActive = true
        bottomViewConstraint.isActive = true
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(tableView)
        
        
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: 0).isActive = true
        
        
        bottomView.layer.zPosition = 2
        bottomView.backgroundColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1)
        //initialize speech text field and set constraints
        
        utterance?.voice = AVSpeechSynthesisVoice(language: "en-US")
        speechField.translatesAutoresizingMaskIntoConstraints = false
        speechField.placeholder = "   Speak here"
       
       
        speechField.font = UIFont.systemFont(ofSize: 17)
        speechField.keyboardType = .default
        speechField.returnKeyType = .default
        speechField.clearButtonMode = .whileEditing
        speechField.isUserInteractionEnabled = true
        speechField.translatesAutoresizingMaskIntoConstraints = false
        speechField.backgroundColor = UIColor(red: 223/255.0, green: 223/255.0, blue: 223/255.0, alpha: 1)
        speechField.delegate = self
        
        bottomView.addSubview(speechField)
        
        
        
        let leadingFieldConstraint = speechField.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20)
        let trailingFieldConstraint = speechField.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -100)
       
       // let widthFieldConstraint = speechField.widthAnchor.constraint(equalToConstant: 250)
        let heightFieldConstraint = speechField.heightAnchor.constraint(equalToConstant: 30)
        
        
        
        leadingFieldConstraint.isActive = true
        trailingFieldConstraint.isActive = true
        //bottomFieldConstraint.isActive = true
        heightFieldConstraint.isActive = true
        
        speechField.layer.zPosition = 1
        
        speechField.layer.cornerRadius = 20
        speechField.layer.cornerRadius = 15.0
        
      
        
        
        
        tableView.register(SpeechCell.self , forCellReuseIdentifier: cellId)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = UIColor( white: 0.98, alpha: 1 )
        
        tableView.allowsSelection = false
        
        //let footerView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        
        
        
        //tableView.tableFooterView = footerView
        
        
        recordButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        bottomView.addSubview(recordButton)
        
        recordImage = UIImage(named: "Microphone Icon.png")!
        
        recordButton.setImage(recordImage , for: .normal)
        
        //let leadingButtonConstraint = recordButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 310)
        //let trailingButtonConstraint = recordButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -5)
        let widthButtonConstraint = recordButton.widthAnchor.constraint(equalToConstant: 30)
        
        let heightButtonConstraint = recordButton.heightAnchor.constraint(equalToConstant: 30)
        
        //leadingButtonConstraint.isActive = true
        //trailingButtonConstraint.isActive = true
        //bottomButtonConstraint.isActive = true
        heightButtonConstraint.isActive = true
        widthButtonConstraint.isActive = true
        
//        speakButton.translatesAutoresizingMaskIntoConstraints = false
//        speakButton.backgroundColor = .red
//        bottomView.addSubview(speakButton)
//
//        let leadingSpeakButtonConstraint = speakButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 290)
//        //let trailingSpeakButtonConstraint = recordButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -50)
//        //let bottomSpeakButtonConstraint = speakButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -10)
//        let heightSpeakButtonConstraint = speakButton.heightAnchor.constraint(equalToConstant: 30)
//        let widthSpeakButtonConstraint = speakButton.widthAnchor.constraint(equalToConstant: 30)
//
//
//        leadingSpeakButtonConstraint.isActive = true
//        //trailingSpeakButtonConstraint.isActive = true
//        //bottomSpeakButtonConstraint.isActive = true
//        heightSpeakButtonConstraint.isActive = true
//        widthSpeakButtonConstraint.isActive = true
        

        
        //speakButton.backgroundColor = .red
        
        speakButton.frame = CGRect( x: speechField.frame.size.width - 25, y: 5.0 , width: 25.0, height: 25.0)
        speakButton.setImage(arrowImage, for: .normal)
        speakButton.imageEdgeInsets = UIEdgeInsets(top: 0 , left: -2, bottom: 0, right: 0)
        speechField.rightView = speakButton
        speechField.rightViewMode = .always
     

        
        tableView.estimatedRowHeight = 50
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
    
    override func viewSafeAreaInsetsDidChange() {
        
        let bottomFieldConstraint : NSLayoutConstraint
        let bottomButtonConstraint : NSLayoutConstraint
        let leadingButtonConstraint : NSLayoutConstraint
        //let bottomSpeakButtonConstraint : NSLayoutConstraint
        if #available(iOS 11.0, *) {
            let bottomPadding = view.safeAreaInsets.bottom
            
            bottomFieldConstraint = speechField.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -10 - bottomPadding)
            bottomButtonConstraint = recordButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -10 - bottomPadding)
            leadingButtonConstraint = recordButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 330)
            
        } else {
            
            bottomFieldConstraint = speechField.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -10)
             bottomButtonConstraint = recordButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -10)
             leadingButtonConstraint = recordButton.leadingAnchor.constraint(equalTo: speechField.trailingAnchor, constant: 30)
           // leadingButtonConstraint = recordButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 30)
            
       
            
            
        }
        
        bottomFieldConstraint.isActive = true
        bottomButtonConstraint.isActive = true
        leadingButtonConstraint.isActive = true
     
    }
    
    
    
    

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
            recordButton.setImage(recordImage , for: .normal)
            recognitionRequest?.endAudio()
            recordButton.isEnabled = true
            //change to true see what happens
            speakButton.isEnabled = false
            //speakButton.isEnabled = false
            
        } else {
            speakButton.isEnabled = false
            speechAssign = SpeechMessage(text: "", isIncoming: true)
            self.speechMessages.append(speechAssign)
            //tableView.scrollToBottom()
            recordButton.setImage(blueMicrophoneImage, for: .normal)
            tableView.reloadData()
            startRecording(speech: speechAssign)
            
            
            
        }
    }
    
    //maybe append "       " speechMessage to last cell to move up view???
    
    @objc func speakButtonTapped(sender: UIButton!) {
        print("speakButtonTapped")
        print(speakButton.isEnabled)
        synth.stopSpeaking(at: .immediate)
        
        
                        let audioSession = AVAudioSession.sharedInstance()
                        do {

                        try audioSession.setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)


                        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)

                    } catch {
                        print("audioSession properties weren't set because of an error.")
                    }

        
        if speakButton.isEnabled == true {
            recordButton.isEnabled = false
            utterance = AVSpeechUtterance(string: speechField.text!)
            synth.speak(utterance!)
           
            
           
            
            speechMessages.append(SpeechMessage(text: speechField.text!, isIncoming: false))
            speechField.text = ""
            

          
            getTableViewData()
            
        }
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer,
                           didFinish utterance: AVSpeechUtterance) {
        recordButton.isEnabled = true
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer,
                           didCancel utterance: AVSpeechUtterance) {
        recordButton.isEnabled = true
    }
    
    func startRecording(speech: SpeechMessage) {
    
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
            recordButton.isEnabled = false
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.record, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
            
            //play and record??
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode
        print("inputNode: \(inputNode)")
        
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            var isFinal = false
            
            if result != nil {
                
                
                
                
               
                
               
               
                
                self.speechMessages[self.speechMessages.count - 1].text = result?.bestTranscription.formattedString ?? ""
                
                 self.tableView.reloadData()
                
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
//                let audioSession = AVAudioSession.sharedInstance()
//                do {
//                
//                try audioSession.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
//                
//                
//                try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
//                
//            } catch {
//                print("audioSession properties weren't set because of an error.")
//            }
//                let audioSession = AVAudioSession.sharedInstance()
//                do {
//                    try audioSession.setCategory(AVAudioSession.Category.record, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
//
//                    //play and record??
//                    try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
//
//                } catch {
//                    print("audioSession properties weren't set because of an error.")
//                }
                
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // print("Cell height: \(cell.frame.size.height)")
        self.cellHeightsDictionary[indexPath] = cell.frame.size.height
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height =  self.cellHeightsDictionary[indexPath] {
            return height
        }
        return UITableView.automaticDimension
    }
    
   
    
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            recordButton.isEnabled = true
        } else {
            recordButton.isEnabled = false
        }
    }
    
//    func tableView(_ tableView: UITableView,
//                            heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
    func getTableViewData(){
        tableView.reloadData()
        
        tableView.scrollToBottom()
    }


    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
       
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
      
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
       
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
      
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
      
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
     
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
     
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
   
        return true
    }
    
}

