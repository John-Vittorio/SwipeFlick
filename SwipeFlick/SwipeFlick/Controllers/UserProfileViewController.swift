//
//  UserProfileViewController.swift
//  SwipeFlick
//
//  Created by Abdul Wahid on 5/23/25.
//

import UIKit

class UserProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let profileStats = ["🍿 Movies Watched: 2", "📋 Watchlist: 4", "❤️ Most Watched Genre: Horror"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        print(UserDefaults.standard.string(forKey: "username")!)
        
        guard UserDefaults.standard.string(forKey: "username") == "Guest" else {
            profileName.text = "\(UserDefaults.standard.string(forKey: "username")!)'s Profile"
            return
        }
//        print(Array(UserDefaults.standard.dictionaryRepresentation()))
        print(UserDefaults.standard.array(forKey: "userGenrePreferences")!)
        print(UserDefaults.standard.array(forKey: "userRatingPreferences")!)
        print(UserDefaults.standard.array(forKey: "userMediumPreferences")!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(UserDefaults.standard.string(forKey: "username")!)
        if UserDefaults.standard.string(forKey: "username") == "Guest" {
            profileName.text = "Guest's Profile"
        } else {
            profileName.text = "\(UserDefaults.standard.string(forKey: "username")!)'s Profile"
            return
        }
    }
    
    @IBAction func unwind(_ unwindSegue: UIStoryboardSegue) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath)
        cell.textLabel?.text = profileStats[indexPath.row];
        cell.textLabel?.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        return cell
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false;
    }
    
}

