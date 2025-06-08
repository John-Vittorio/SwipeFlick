//
//  OnboardingWelcomeViewController.swift
//  SwipeFlick
//
//  Created by Amber Wu on 5/26/25.
//

import UIKit

class OnboardingWelcomeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBAction func tapNextBtn(_ sender: Any) {
        let name = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let finalName = (name?.isEmpty ?? true) ? "Guest" : name!
        UserDefaults.standard.set(finalName, forKey: "username")
        print(UserDefaults.standard.string(forKey: "username")!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.nameTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
