//  File: SelectGenreTableVC.swift
//  Project: Project33-WhatsThatWhistile2
//  Created by: Noah Pope on 1/15/26.

import UIKit

class SelectGenreTableVC: UITableViewController
{
    static var genres = ["Unknown", "Blues", "Classical", "Electronic", "Jazz", "Metal", "Pop", "Reggaeton", "RnB", "Rock", "Soul"]

    override func viewDidLoad()
    {
        super.viewDidLoad()
        configNavigation()
    }
    
    //-------------------------------------//
    // MARK: - CONFIGURATION
    
    func configNavigation()
    {
        title = "Select genre"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Genre", style: .plain, target: nil, action: nil)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return SelectGenreTableVC.genres.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = SelectGenreTableVC.genres[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if let cell = tableView.cellForRow(at: indexPath) {
            let genre = cell.textLabel?.text ?? SelectGenreTableVC.genres[0] //conditional binding vs nilcoall
            let vc = AddCommentsVC()
            vc.genre = genre
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
