//
//  AgeRatingController.swift
//  Project Testing
//
//  Created by James Nguyen on 5/31/25.
//

import UIKit


class MediumController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var mediumTable: UITableView!
    
    let mediums = ["Live-Action", "Animation", "Stop-Motion", "Anime"]
    var selectedMediums : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        selectedMediums = UserDefaults.standard.array(forKey: "userMediumPreferences") as! [String]
        mediumTable.delegate = self
        mediumTable.dataSource = self
        print(UserDefaults.standard.array(forKey: "userMediumPreferences")!)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediums.count
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        UserDefaults.standard.set(selectedMediums, forKey: "userMediumPreferences")
        print(UserDefaults.standard.array(forKey: "userMediumPreferences")!)
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MediumCell", for: indexPath)
        cell.textLabel?.text = mediums[indexPath.row];
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        if selectedMediums.contains(cell.textLabel?.text ?? "") {
            cell.accessoryType = .checkmark
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            if let cell = tableView.cellForRow(at: indexPath) {
                selectedMediums.removeAll(where: { $0 == cell.textLabel!.text})
            }
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            if let cell = tableView.cellForRow(at: indexPath),
               !selectedMediums.contains(cell.textLabel!.text ?? "") {
                selectedMediums.append(cell.textLabel!.text ?? "")
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

