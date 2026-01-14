//  File: RecordWhistleVC.swift
//  Project: Project33-WhatsThatWhistile2
//  Created by: Noah Pope on 1/7/26.

import UIKit
import AVFoundation

class RecordWhistleVC: UIViewController
{
    var stackView: UIStackView!
    
    var recordButton: UIButton!
    var recordingSession: AVAudioSession!
    var whistleRecorder: AVAudioRecorder!
    
    
    override func loadView()
    {
        configStackView()
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configNavigation()
        configRecordingSession()
    }
    
    //-------------------------------------//
    // MARK: - CONFIGURATION
    
    func configStackView()
    {
        view = UIView()
        view.backgroundColor = UIColor.gray
        
        stackView = UIStackView()
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = UIStackView.Distribution.fillEqually
        stackView.alignment = .center
        stackView.axis = .vertical
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        //OG CODE FROM BOOK, I REFACTORED IT TO REPEAT THE .ISACTIVE STUFF
//        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    
    func configNavigation()
    {
        title = "Record your whistle"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Record", style: .plain, target: nil, action: nil)
    }
    
    
    func configRecordingSession()
    {
        recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async { allowed ? self.loadRecordingUI() : self.loadFailUI() }
            }
        } catch {
            self.loadFailUI()
        }
    }
    
    //-------------------------------------//
    // MARK: - MAIN METHODS
    
    func loadRecordingUI()
    {
        recordButton = UIButton()
        recordButton.translatesAutoresizingMaskIntoConstraints = false
        recordButton.setTitle("Tap to Record", for: .normal)
        recordButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        recordButton.addTarget(self, action: #selector(recordTapped), for: .touchUpInside)
        
        stackView.addArrangedSubview(recordButton)
    }
    
    
    func loadFailUI()
    {
        let failLabel = UILabel()
        failLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        failLabel.text = "Recording failed. Please ensure the app has access to your microphone."
        failLabel.numberOfLines = 0
        
        stackView.addArrangedSubview(failLabel)
    }
    
    
    @objc func recordTapped()
    {
        
    }
    
    
    func startRecording()
    {
        view.backgroundColor = UIColor(red: 0.6, green: 0, blue: 0, alpha: 1)
        recordButton.setTitle("Tap to Stop", for: .normal)
        let audioURL = RecordWhistleVC.getWhistleURL()
        print(audioURL.absoluteString)
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 1200,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            whistleRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
            whistleRecorder.delegate = self
            whistleRecorder.record()
        } catch {
            finishRecording(success: false)
        }
    }
    
    
    func finishRecording(success: Bool)
    {
        
    }
    
    //-------------------------------------//
    // MARK: - WRITING TO MEMORY (TO DOCUMENTS DIRECTORY)
    
    class func getDocumentsDirectory() -> URL
    {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        // use Finder to go to what's printed beneath after recording to ensure file writing works
        print("documentsDirectoryPath = \(documentsDirectory)")
        return documentsDirectory
    }
    
    
    // replace 'Document' with more specific name (e.g. getWhistleUrl)
    // then add an appending path component (preferably from Keys in Constants+Utils)
    class func getWhistleURL() -> URL
    {
        return getDocumentsDirectory().appendingPathComponent("whistle.m4a")
    }
}
