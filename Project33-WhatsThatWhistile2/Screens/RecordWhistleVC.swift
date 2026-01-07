//  File: RecordWhistleVC.swift
//  Project: Project33-WhatsThatWhistile2
//  Created by: Noah Pope on 1/7/26.

import UIKit

class RecordWhistleVC: UIViewController
{
    var stackView: UIStackView!
    
    
    override func loadView()
    {
        configStackView()
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }
    
    
    func configStackView()
    {
        view = UIView()
        //view = view that controller manages
        //UIView = object that manages content for rectangular area on screen
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
}
