//
//  GenreController.swift
//  Project Testing
//
//  Created by James Nguyen on 5/25/25.
//

import UIKit


class GenreController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var genreTable: UITableView!
    
    let genres = ["Horror", "Action", "Drama", "Romance", "Comedy", "Fantasy", "Sci-fi", "Thriller", "Adventure", "Crime", "Western", "Historical"]
    var selectedGenres : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        selectedGenres = UserDefaults.standard.array(forKey: "userGenrePreferences") as! [String]
        genreTable.delegate = self
        genreTable.dataSource = self
        print(UserDefaults.standard.array(forKey: "userGenrePreferences")!)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        UserDefaults.standard.set(selectedGenres, forKey: "userGenrePreferences")
        print(UserDefaults.standard.array(forKey: "userGenrePreferences")!)
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "genreCell", for: indexPath)
        cell.textLabel?.text = genres[indexPath.row];
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        if selectedGenres.contains(cell.textLabel?.text ?? "") {
            cell.accessoryType = .checkmark
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            if let cell = tableView.cellForRow(at: indexPath) {
                selectedGenres.removeAll(where: { $0 == cell.textLabel!.text})
            }
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            if let cell = tableView.cellForRow(at: indexPath), !selectedGenres.contains(cell.textLabel!.text ?? "") {
                selectedGenres.append(cell.textLabel!.text ?? "")
            }
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
