//
//  MovieProfileViewController.swift
//  SwipeFlick
//
//  Created by Ashwin Subramanian on 5/26/25.
//

import UIKit

class MovieProfileViewController: UIViewController {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var ageRatingLabel: UILabel!
    @IBOutlet weak var mediumLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var selectedMovie: Movie?
    var movieTitle: String? // if passing title from the watchlist
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        displayMovieDetails()
    }
    
    private func setupUI() {
        navigationItem.title = "Movie Details"
        movieImageView.layer.cornerRadius = 12
        movieImageView.clipsToBounds = true
        movieImageView.contentMode = .scaleAspectFill
        movieTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        movieTitleLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .secondaryLabel
        setupInfoLabels()
    }
    
    private func setupInfoLabels() {
        let infoLabels = [releaseYearLabel, ageRatingLabel, mediumLabel]
        
        for label in infoLabels {
            label?.font = UIFont.systemFont(ofSize: 16)
            label?.textColor = .label
        }
    }
    
    private func displayMovieDetails() {
        guard let movie = selectedMovie else {
            // try searching by title
            if let title = movieTitle {
                findMovieByTitle(title)
            }
            return
        }
        
        movieTitleLabel.text = movie.title
        releaseYearLabel.text = "Release Year: \(movie.releaseYear)"
        ageRatingLabel.text = "Age Rating: \(movie.rating)"
        mediumLabel.text = "Medium: Live-Action"
        descriptionLabel.text = movie.description
        loadMovieImage(from: movie.imageURL)
    }
    
    private func findMovieByTitle(_ title: String) {
        if let foundMovie = Movie.mockMovies.first(where: { $0.title.lowercased().contains(title.lowercased()) }) {
            selectedMovie = foundMovie
            displayMovieDetails()
        } else {
            // fallback from watchlist
            movieTitleLabel.text = title
            releaseYearLabel.text = "Release Year: N/A"
            ageRatingLabel.text = "Age Rating: N/A"
            mediumLabel.text = "Medium: N/A"
            descriptionLabel.text = "Movie details not available"
        }
    }
    
    private func loadMovieImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.movieImageView.image = image
                }
            }
        }.resume()
    }
}
