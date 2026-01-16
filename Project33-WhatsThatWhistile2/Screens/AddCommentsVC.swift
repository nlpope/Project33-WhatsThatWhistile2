//  File: AddCommentsVC.swift
//  Project: Project33-WhatsThatWhistile2
//  Created by: Noah Pope on 1/15/26.

import UIKit

class AddCommentsVC: UIViewController, UITextViewDelegate
{
    var genre: String!
    var commentsView: UITextView!
    let placeholder = "If you have any additional comments that might help identify your tune, enter them here."
    
    
    override func loadView()
    {
        configView()
        configCommentsView()
    }

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    //-------------------------------------//
    // MARK: - CONFIGURATION
    
    func configNavigation()
    {
        title = "Comments"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(submitTapped))
        commentsView.text = placeholder
    }
    
    
    func configView()
    {
        view = UIView()
        view.backgroundColor = .white
    }
    
    
    func configCommentsView()
    {
        commentsView = UITextView()
        commentsView.translatesAutoresizingMaskIntoConstraints = false
        commentsView.delegate = self
        commentsView.font = UIFont.preferredFont(forTextStyle: .body)
        
        view.addSubview(commentsView)
        
        NSLayoutConstraint.activate([
            commentsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            commentsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            commentsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            commentsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    //-------------------------------------//
    // MARK: - SUPPORTING METHODS
    
    @objc func submitTapped()
    {
        let vc = SubmitVC()
        vc.genre = genre
        vc.comments = commentsView.text == placeholder ? "" : commentsView.text
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
