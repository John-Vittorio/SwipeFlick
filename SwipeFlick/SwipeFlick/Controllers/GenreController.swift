//
//  GenreController.swift
//  Project Testing
//
//  Created by James Nguyen on 5/25/25.
//

import UIKit


class GenreController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var genreTable: UITableView!
    
    let genres = ["Horror", "Action", "Drama", "Romance", "Comedy", "Fantasy", "Sci-fi", "Thriller", "Adventure", "Crime/Mystery", "Western", "Historical"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        genreTable.delegate = self
        genreTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "genreCell", for: indexPath)
        cell.textLabel?.text = genres[indexPath.row];
        cell.textLabel?.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
