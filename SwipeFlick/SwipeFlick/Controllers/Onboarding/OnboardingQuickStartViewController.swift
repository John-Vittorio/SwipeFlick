//
//  OnboardingQuickStartViewController.swift
//  SwipeFlick
//
//  Created by Amber Wu on 5/26/25.
//

import UIKit

class OnboardingQuickStartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func toSwipeController(_ sender: Any) {

        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
        print(UserDefaults.standard.bool(forKey: "hasCompletedOnboarding"))
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController {
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let sceneDelegate = windowScene.delegate as? SceneDelegate,
                  let window = sceneDelegate.window else { return }
            
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
            
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
        }
    }

}
