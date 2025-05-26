//
//  OnboardingGenreViewController.swift
//  SwipeFlick
//
//  Created by Amber Wu on 5/26/25.
//

import UIKit

class GenreCell: UICollectionViewCell {
    @IBOutlet weak var genreLabel: UILabel!
    
}

class OnboardingGenreViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var genreCollectionView: UICollectionView!
    
    let genres = ["Horror", "Action", "Drama", "Romance", "Comedy", "Fantasy", "Sci-fi", "Thriller", "Adventure", "Crime/Mystery", "Western", "Historical"]
    var selectedGenres: Set<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        genreCollectionView.delegate = self
        genreCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCell", for: indexPath) as! GenreCell
        let genre = genres[indexPath.item]
        cell.genreLabel.text = genre
        
        let isSelected = selectedGenres.contains(genre)
        cell.contentView.backgroundColor = isSelected ? .systemRed : .systemGray5
        cell.genreLabel.textColor = isSelected ? .systemYellow : .black
        cell.contentView.layer.cornerRadius = 12
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let genre = genres[indexPath.item]
        if selectedGenres.contains(genre) {
            selectedGenres.remove(genre)
        } else {
            selectedGenres.insert(genre)
        }
        collectionView.reloadItems(at: [indexPath])
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
