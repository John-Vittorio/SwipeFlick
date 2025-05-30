//
//  OnboardingOtherPreferencesViewController.swift
//  SwipeFlick
//
//  Created by Amber Wu on 5/26/25.
//

import UIKit

class MediumCell: UICollectionViewCell {
    @IBOutlet weak var mediumLabel: UILabel!
}

class OnboardingOtherPreferencesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var mediumCollectionView: UICollectionView!
    @IBOutlet weak var ageRatingCollectionView: UICollectionView!
    @IBOutlet weak var fromYearTextField: UITextField!
    @IBOutlet weak var toYearTextField: UITextField!
    @IBAction func tapNextBtn(_ sender: Any) {
        let finalSelectedMediums = Array(selectedMediums)
        let finalSelectedRatings = Array(selectedRatings)
        UserDefaults.standard.set(finalSelectedMediums, forKey: "userMediumPreferences")
        UserDefaults.standard.set(finalSelectedRatings, forKey: "userRatingPreferences")
    }
    
    let mediums = ["Live-Action", "Animation", "Stop-Motion", "Anime"]
    let ageRatings = ["G", "PG", "PG-13", "R", "NC-17"]
    
    var selectedMediums: Set<String> = []
    var selectedRatings: Set<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mediumCollectionView.delegate = self
        mediumCollectionView.dataSource = self
        ageRatingCollectionView.delegate = self
        ageRatingCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mediumCollectionView {
            return mediums.count
        } else if collectionView == ageRatingCollectionView {
            return ageRatings.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mediumCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediumCell", for: indexPath) as! MediumCell
            let medium = mediums[indexPath.item]
            cell.mediumLabel.text = medium
            
            let isSelected = selectedMediums.contains(medium)
            cell.contentView.backgroundColor = isSelected ? .systemRed : .systemGray5
            cell.mediumLabel.textColor = isSelected ? .systemYellow : .black
            cell.contentView.layer.cornerRadius = 12
            
            return cell
        } else if collectionView == ageRatingCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgeRatingCell", for: indexPath) as! MediumCell
            let ageRating = ageRatings[indexPath.item]
            cell.mediumLabel.text = ageRating
            
            let isSelected = selectedRatings.contains(ageRating)
            cell.contentView.backgroundColor = isSelected ? .systemRed : .systemGray5
            cell.mediumLabel.textColor = isSelected ? .systemYellow : .black
            cell.contentView.layer.cornerRadius = 12
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == mediumCollectionView {
            let medium = mediums[indexPath.item]
            if selectedMediums.contains(medium) {
                selectedMediums.remove(medium)
            } else {
                selectedMediums.insert(medium)
            }
            collectionView.reloadItems(at: [indexPath])
        } else if collectionView == ageRatingCollectionView {
            let ageRating = ageRatings[indexPath.item]
            if selectedRatings.contains(ageRating) {
                selectedRatings.remove(ageRating)
            } else {
                selectedRatings.insert(ageRating)
            }
            collectionView.reloadItems(at: [indexPath])
        }

    }

    // vertical padding
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    // horizontal padding
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 16, left: 12, bottom: 16, right: 12)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPAth: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 12 * 2 - 12 * 2) / 3
        return CGSize(width:width, height: 50)
    }

}
