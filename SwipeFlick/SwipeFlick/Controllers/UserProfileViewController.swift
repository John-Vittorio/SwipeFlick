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
    
    var profileStats = ["🍿 Movies Watched: 0", "📋 Watchlist: 0", "❤️ Common Genre: NA"]
    var genreDict: [String : Int] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        if UserDefaults.standard.string(forKey: "username") != "Guest" {
            profileName.text = "\(UserDefaults.standard.string(forKey: "username")!)'s Profile"
        }
        let movieCount = WatchlistManager.shared.getWatchlist().count
        if movieCount > 0 {
            print("meow")
            profileStats[1] = "📋 Watchlist: \(movieCount)"
            profileStats[2] = "❤️ Common Genre (from Watchlist): \(findMostCommonGenre())"
        } else {
            print("hiss")
            print(WatchlistManager.shared.getWatchlist())
            profileStats[1] = "📋 Watchlist: 0"
            profileStats[2] = "❤️ Common Genre (from Watchlist): N/A"
        }
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.string(forKey: "username") == "Guest" {
            profileName.text = "Guest's Profile"
        } else {
            profileName.text = "\(UserDefaults.standard.string(forKey: "username")!)'s Profile"
        }
                
        let movieCount = WatchlistManager.shared.getWatchlist().count
        if movieCount > 0 {
            print("meow")
            profileStats[1] = "📋 Watchlist: \(movieCount)"
            profileStats[2] = "❤️ Common Genre (from Watchlist): \(findMostCommonGenre())"
        } else {
            print("hiss")
            print(WatchlistManager.shared.getWatchlist())
            profileStats[1] = "📋 Watchlist: 0"
            profileStats[2] = "❤️ Common Genre (from Watchlist): N/A"
        }
        tableView.reloadData();
    }
    
    @IBAction func unwind(_ unwindSegue: UIStoryboardSegue) {
        
    }
    
    func findMostCommonGenre() -> String {
        for movie in WatchlistManager.shared.getWatchlist() {
            for genre in movie.genre {
                if genreDict[genre] == nil {
                    genreDict[genre] = 1
                } else {
                    genreDict[genre] = (genreDict[genre] ?? 0) + 1
                }
            }
        }
        
        var mostCommonGenre: String?
        var highestCount: Int?
        for (genre, count) in genreDict {
            if mostCommonGenre == nil || count > (highestCount ?? 0) {
                mostCommonGenre = genre
                highestCount = count
            }
        }
        
        return mostCommonGenre ?? "N/A";
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath)
        cell.textLabel?.text = profileStats[indexPath.row];
        cell.textLabel?.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false;
    }
    
}

