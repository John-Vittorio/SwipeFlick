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
    
    private var watchedLabel: UILabel?
    private var markWatchedButton: UIButton?
    private var isWatched: Bool = false {
        didSet {
            updateWatchedStatus()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        displayMovieDetails()
        setupWatchedButton()
        loadWatchedStatus()
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
    
    private func setupWatchedButton() {
        markWatchedButton = UIButton(type: .system)
        guard let button = markWatchedButton else { return }
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Mark as Watched", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.addTarget(self, action: #selector(markWatchedTapped), for: .touchUpInside)
        
        view.addSubview(button)
        
        watchedLabel = UILabel()
        guard let label = watchedLabel else { return }
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "✅ WATCHED"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .systemGreen
        label.textAlignment = .center
        label.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.1)
        label.layer.cornerRadius = 8
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.systemGreen.cgColor
        label.clipsToBounds = true
        label.isHidden = true
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 50),
            
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            label.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            label.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func markWatchedTapped() {
        isWatched = true
        saveWatchedStatus()
        
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
        
        showWatchedConfirmation()
    }
    
    private func showWatchedConfirmation() {
        let confirmationLabel = UILabel()
        confirmationLabel.text = "Added to watched movies! 🎬"
        confirmationLabel.textColor = .systemGreen
        confirmationLabel.font = UIFont.boldSystemFont(ofSize: 16)
        confirmationLabel.textAlignment = .center
        confirmationLabel.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        confirmationLabel.layer.cornerRadius = 8
        confirmationLabel.clipsToBounds = true
        confirmationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(confirmationLabel)
        
        NSLayoutConstraint.activate([
            confirmationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            confirmationLabel.widthAnchor.constraint(equalToConstant: 280),
            confirmationLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        confirmationLabel.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            confirmationLabel.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: 2.0, animations: {
                confirmationLabel.alpha = 0
            }) { _ in
                confirmationLabel.removeFromSuperview()
            }
        }
    }
    
    private func updateWatchedStatus() {
        markWatchedButton?.isHidden = isWatched
        watchedLabel?.isHidden = !isWatched
    }
    
    private func saveWatchedStatus() {
        guard let movie = selectedMovie else { return }
        let watchedMoviesKey = "watchedMovies"
        var watchedMovies = UserDefaults.standard.array(forKey: watchedMoviesKey) as? [String] ?? []
        
        if !watchedMovies.contains(movie.title) {
            watchedMovies.append(movie.title)
            UserDefaults.standard.set(watchedMovies, forKey: watchedMoviesKey)
        }
    }
    
    private func loadWatchedStatus() {
        guard let movie = selectedMovie else { return }
        let watchedMoviesKey = "watchedMovies"
        let watchedMovies = UserDefaults.standard.array(forKey: watchedMoviesKey) as? [String] ?? []
        
        isWatched = watchedMovies.contains(movie.title)
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
            loadWatchedStatus()
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
