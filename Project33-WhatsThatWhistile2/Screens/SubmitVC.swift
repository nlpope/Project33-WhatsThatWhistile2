//  File: SubmitVC.swift
//  Project: Project33-WhatsThatWhistile2
//  Created by: Noah Pope on 1/16/26.

import UIKit

class SubmitVC: UIViewController
{
    var genre: String!
    var comments: String!
    var stackView: UIStackView!
    var statusLabel: UILabel!
    var spinner: UIActivityIndicatorView!
    
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
    }
    
    //-------------------------------------//
    // MARK: - CONFIGURATION
    
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
}
