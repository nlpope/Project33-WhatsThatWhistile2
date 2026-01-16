//  File: SubmitVC.swift
//  Project: Project33-WhatsThatWhistile2
//  Created by: Noah Pope on 1/16/26.

import UIKit

class SubmitVC: UIViewController
{
    var genre: String!
    var comments: String!
    var stackView: UIStackView!
    var status: UILabel!
    var spinner: UIActivityIndicatorView!
    
    override func loadView()
    {
        configView()
        configStackView()
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
        
    }
}
