//
//  ViewController.swift
//  SwipeFlick
//
//  Created by Abdul Wahid on 5/24/25.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func watchListNavigation(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToWatchList", sender: self)
    }
    
    @IBAction func swipeNavigation(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToSwipePage", sender: self)
    }
    
    
    @IBAction func profileNavigation(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToUserProfile", sender: self)
        
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
