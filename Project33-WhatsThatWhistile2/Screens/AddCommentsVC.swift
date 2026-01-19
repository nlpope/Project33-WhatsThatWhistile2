//  File: AddCommentsVC.swift
//  Project: Project33-WhatsThatWhistile2
//  Created by: Noah Pope on 1/15/26.

import UIKit

class AddCommentsVC: UIViewController, UITextViewDelegate
{
    var genre: String!
    //commentsView.text from here on is considered metadata b/c it's carried over to other VC's
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
        configNavigation()
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
    
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        #warning("when is this triggered and why would it match the placeholder if they've already edited it to be different by @ least 1 char")
        print("textViewDidBeginEditing triggered")
        
        if textView.text == placeholder { textView.text = "" }
    }
}
