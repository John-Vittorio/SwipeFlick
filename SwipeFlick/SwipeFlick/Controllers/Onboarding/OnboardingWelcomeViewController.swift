//
//  OnboardingWelcomeViewController.swift
//  SwipeFlick
//
//  Created by Amber Wu on 5/26/25.
//

import UIKit

class OnboardingWelcomeViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBAction func tapNextBtn(_ sender: Any) {
        let name = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let finalName = (name?.isEmpty ?? true) ? "Guest" : name!
        UserDefaults.standard.set(finalName, forKey: "username")
        print(UserDefaults.standard.string(forKey: "username")!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
