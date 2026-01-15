//  File: RecordWhistleVC.swift
//  Project: Project33-WhatsThatWhistile2
//  Created by: Noah Pope on 1/7/26.

import UIKit
import AVFoundation

class RecordWhistleVC: UIViewController, AVAudioRecorderDelegate
{
    var stackView: UIStackView!
    
    var recordButton: UIButton!
    var recordingSession: AVAudioSession!
    var whistleRecorder: AVAudioRecorder!
    var whistlePlayer: AVAudioPlayer!
    var playButton: UIButton!
    var recordingInBucket: Bool = false
    
    
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
            #warning("why is this unowned?")
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async { allowed ? self.configRecordingUI() : self.configFailUI() }
            }
        } catch {
            self.configFailUI()
        }
    }
    
    
    func configRecordingUI()
    {
        recordButton = UIButton()
        recordButton.translatesAutoresizingMaskIntoConstraints = false
        recordButton.setTitle("Tap to Record", for: .normal)
        recordButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        recordButton.addTarget(self, action: #selector(recordTapped), for: .touchUpInside)
        
        stackView.addArrangedSubview(recordButton)
        
        playButton = UIButton()
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.setTitle("Tap to Play", for: .normal)
        playButton.isHidden = true
        playButton.alpha = 0
        playButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        playButton.addTarget(self, action: #selector(playTapped), for: .touchUpInside)
        
        stackView.addArrangedSubview(playButton)
    }
    
    
    func configFailUI()
    {
        let failLabel = UILabel()
        failLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        failLabel.text = "Recording failed. Please ensure the app has access to your microphone."
        failLabel.numberOfLines = 0
        
        stackView.addArrangedSubview(failLabel)
    }
    
    //-------------------------------------//
    // MARK: - SUPPORTING METHODS
    
    func togglePlayButton()
    {
        if !recordingInBucket { return }
        #warning("why unowned self")
        UIView.animate(withDuration: 0.35) { [unowned self] in
            self.playButton.isHidden = self.playButton.isHidden ? false : true
            self.playButton.alpha = self.playButton.isHidden ? 0 : 1
        }
    }
    
    
    @objc func recordTapped()
    {
        if whistleRecorder == nil { startRecording(); togglePlayButton() }
        else { finishRecording(success: true) }
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
        view.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0, alpha: 1)
        
        whistleRecorder.stop()
        whistleRecorder = nil
        recordingInBucket = true
        
        if success {
            recordButton.setTitle("Tap to Re-record:", for: .normal)
            togglePlayButton()
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextTapped))
        } else {
            recordButton.setTitle("Tap to Record", for: .normal)
            
            let msg = "there was a problem recording your whistle. Please try again."
            let ac = UIAlertController(title: "Record failed", message: msg, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    
    @objc func playTapped()
    {
        let url = RecordWhistleVC.getWhistleURL()
        
        do {
            whistlePlayer = try AVAudioPlayer(contentsOf: url)
            whistlePlayer.play()
        } catch {
            let msg = "There was a problem playing your whistle; please try re-recording."
            let ac = UIAlertController(title: "Playback failed", message: msg, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    
    @objc func nextTapped()
    {
        
    }
    
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool)
    {
        if !flag { finishRecording(success: false) }
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
    
    
    class func getWhistleURL() -> URL
    {
        return getDocumentsDirectory().appendingPathComponent("whistle.m4a")
    }
}
