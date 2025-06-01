//
//  PreferenceController.swift
//  SwipeFlick
//
//  Created by James Nguyen on 5/27/25.
//

import UIKit

class PreferenceController: UIViewController {

    @IBOutlet weak var genreBtn: UIButton!
    @IBOutlet weak var firstYear: UITextField!
    @IBOutlet weak var secondYear: UITextField!
    @IBOutlet weak var name: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        genreBtn.contentHorizontalAlignment = .left
        if UserDefaults.standard.string(forKey: "username") != "Guest" {
            name.text = UserDefaults.standard.string(forKey: "username");
        }
        if UserDefaults.standard.array(forKey: "userMovieAgePreferences") != nil {
            let movieAgeArr = UserDefaults.standard.array(forKey: "userMovieAgePreferences") as? [Int] ?? [1900, 2050]
            firstYear.text = String(movieAgeArr[0])
            secondYear.text = String(movieAgeArr[1])
        }
    }
    
    @IBAction func unwindToSettings(_ unwindSegue: UIStoryboardSegue) {
        
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        // userMovieAgePreferences
        // username
        if firstYear.text != "", secondYear.text != "" {
            let fromMovieAge = Int(firstYear.text ?? "") ?? 1900
            let toMovieAge = Int(secondYear.text ?? "") ?? 2050
            let finalMovieAge = [fromMovieAge, toMovieAge]
            UserDefaults.standard.set(finalMovieAge, forKey: "userMovieAgePreferences")
            print(UserDefaults.standard.array(forKey: "userMovieAgePreferences") ?? ["", ""])
        }
        
        if UserDefaults.standard.string(forKey: "username") != name.text {
            if name.text?.count == 0 {
                UserDefaults.standard.set("Guest", forKey: "username")
            } else {
                UserDefaults.standard.set(name.text, forKey: "username")
            }
        }
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
