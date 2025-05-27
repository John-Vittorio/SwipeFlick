//
//  PreferenceController.swift
//  SwipeFlick
//
//  Created by James Nguyen on 5/27/25.
//

import UIKit

class PreferenceController: UIViewController {

    @IBOutlet weak var genreBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        genreBtn.contentHorizontalAlignment = .left

    }
    
    @IBAction func unwindToSettings(_ unwindSegue: UIStoryboardSegue) {
        
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
