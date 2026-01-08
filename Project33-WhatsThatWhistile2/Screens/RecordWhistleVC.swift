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
        
    }
    
    
    func loadFailUI()
    {
        
    }
}
