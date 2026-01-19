//  File: SubmitVC.swift
//  Project: Project33-WhatsThatWhistile2
//  Created by: Noah Pope on 1/16/26.

import UIKit
import CloudKit

class SubmitVC: UIViewController
{
    var genre: String!
    var comments: String!
    
    var stackView: UIStackView!
    var statusLabel: UILabel!
    var spinner: UIActivityIndicatorView!
    
    static var isDirty: Bool = false
    
    override func loadView()
    {
        configView()
        configStackView()
        configStatusLabel()
        configSpinner()
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configNavigation()
    }
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        doSubmission()
    }
    
    //-------------------------------------//
    // MARK: - CONFIGURATION
    
    func configNavigation()
    {
        title = "You're all set"
        navigationItem.hidesBackButton = true
    }
    
    
    func configView()
    {
        view = UIView()
        view.backgroundColor = UIColor.gray
    }
    
    
    func configStackView()
    {
        stackView = UIStackView()
        stackView.spacing = 10
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
    
    
    func configStatusLabel()
    {
        statusLabel = UILabel()
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.text = "Submitting..."
        statusLabel.textColor = UIColor.white
        statusLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        statusLabel.numberOfLines = 0
        statusLabel.textAlignment = .center
        
        stackView.addArrangedSubview(statusLabel)
    }
    
    
    func configSpinner()
    {
        spinner = UIActivityIndicatorView(style: .whiteLarge)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        
        stackView.addArrangedSubview(spinner)
    }
    
    //-------------------------------------//
    // MARK: - SUPPORTING METHODS
    
    func doSubmission()
    {
        //1 create the record to send to icloud
        let whistleRecord = CKRecord(recordType: CKRecordStrings.whistles)
        whistleRecord["genre"] = genre as CKRecordValue
        whistleRecord["comments"] = comments as CKRecordValue
        
        let audioURL = RecordWhistleVC.getWhistleURL()
        let whistleAsset = CKAsset(fileURL: audioURL)
        whistleRecord["audio"] = whistleAsset
        
        //2 handle the result
        CKContainer.default().publicCloudDatabase.save(whistleRecord) { [unowned self] record, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.statusLabel.text = "Error: \(error.localizedDescription)"
                    self.spinner.stopAnimating()
                } else {
                    self.view.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0, alpha: 1)
                    self.statusLabel.text = "Done!"
                    
                    self.spinner.stopAnimating()
                    SubmitVC.isDirty = true
                }
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneTapped))
            }
        }
    }

    
    @objc func doneTapped()
    {
        _ = navigationController?.popToRootViewController(animated: true)
    }
}
