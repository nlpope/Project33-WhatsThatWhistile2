//  File: ViewController.swift
//  Project: Project33-WhatsThatWhistile2
//  Created by: Noah Pope on 1/7/26.

import UIKit

class ViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configVC()
    }
    
    
    func configVC()
    {
        title = "What's that whistle?"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWhistle))
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: nil, action: nil)
    }
    
    
    @objc func addWhistle()
    {
        let vc = RecordWhistleVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
