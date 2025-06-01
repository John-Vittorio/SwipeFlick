//
//  AgeRatingController.swift
//  Project Testing
//
//  Created by James Nguyen on 5/31/25.
//

import UIKit


class AgeRatingController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var ageRatingTable: UITableView!
    
//    let mediums = ["Live-Action", "Animation", "Stop-Motion", "Anime"]
    let ageRatings = ["G", "PG", "PG-13", "R", "NC-17"]
    var selectedRatings : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        selectedRatings = UserDefaults.standard.array(forKey: "userRatingPreferences") as! [String]
        ageRatingTable.delegate = self
        ageRatingTable.dataSource = self
        print(UserDefaults.standard.array(forKey: "userRatingPreferences")!)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ageRatings.count
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        UserDefaults.standard.set(selectedRatings, forKey: "userRatingPreferences")
        print(UserDefaults.standard.array(forKey: "userRatingPreferences")!)
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RatingCell", for: indexPath)
        cell.textLabel?.text = ageRatings[indexPath.row];
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        if selectedRatings.contains(cell.textLabel?.text ?? "") {
            cell.accessoryType = .checkmark
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            if let cell = tableView.cellForRow(at: indexPath) {
                selectedRatings.removeAll(where: { $0 == cell.textLabel!.text})
            }
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            if let cell = tableView.cellForRow(at: indexPath), !selectedRatings.contains(cell.textLabel!.text ?? "") {
                selectedRatings.append(cell.textLabel!.text ?? "")
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

