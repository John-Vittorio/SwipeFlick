//
//  SwipeViewController.swift
//  SwipeFlick
//
//  Created by Abdul Wahid on 5/23/25.
//

import UIKit

class SwipeViewController: UIViewController {

    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var dislikeButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var movieImage: UIImageView!
    
    private var currentMovieIndex = 0
    private var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadMovies()
        displayCurrentMovie()
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeft(_:)))
        swipeLeft.direction = .left
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRight(_:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeLeft)
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc func handleSwipeLeft(_ gesture: UISwipeGestureRecognizer) {
        handleSwipe(direction: .left)
    }
    
    @objc func handleSwipeRight(_ gesture: UISwipeGestureRecognizer) {
        if currentMovieIndex < movies.count {
            let movie = movies[currentMovieIndex]
            WatchlistManager.shared.addToWatchlist(movie)
            
            // Show brief feedback
            showWatchlistFeedback()
        }
        handleSwipe(direction: .right)
    }
    
    private func setupUI() {
        likeButton.layer.cornerRadius = likeButton.frame.size.width / 2
        likeButton.clipsToBounds = true
        dislikeButton.layer.cornerRadius = dislikeButton.frame.size.width / 2
        dislikeButton.clipsToBounds = true
        
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        dislikeButton.addTarget(self, action: #selector(dislikeButtonTapped), for: .touchUpInside)
    }
    
    private func loadMovies() {
        movies = Movie.mockMovies
    }
    
    private func displayCurrentMovie() {
        guard currentMovieIndex < movies.count else {
            movieTitle.text = "No more movies!"
            movieDescription.text = nil
            movieImage.image = nil
            return
        }
        
        let movie = movies[currentMovieIndex]
        movieTitle.text = movie.title
        movieDescription.text = movie.description
        
        if let url = URL(string: movie.imageURL) {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.movieImage.image = image
                    }
                }
            }.resume()
        }
    }
    
    @objc private func likeButtonTapped() {
        // Add movie to watchlist when liked
        if currentMovieIndex < movies.count {
            let movie = movies[currentMovieIndex]
            WatchlistManager.shared.addToWatchlist(movie)
            
            // Show brief feedback
            showWatchlistFeedback()
        }
        handleSwipe(direction: .right)
    }
    
    @objc private func dislikeButtonTapped() {
        handleSwipe(direction: .left)
    }
    
    private func showWatchlistFeedback() {
        let feedbackLabel = UILabel()
        feedbackLabel.text = "Added to Watchlist ✓"
        feedbackLabel.textColor = .systemGreen
        feedbackLabel.font = UIFont.boldSystemFont(ofSize: 16)
        feedbackLabel.textAlignment = .center
        feedbackLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        feedbackLabel.layer.cornerRadius = 8
        feedbackLabel.clipsToBounds = true
        feedbackLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(feedbackLabel)
        
        NSLayoutConstraint.activate([
            feedbackLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            feedbackLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            feedbackLabel.widthAnchor.constraint(equalToConstant: 200),
            feedbackLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        feedbackLabel.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            feedbackLabel.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: 1.0, animations: {
                feedbackLabel.alpha = 0
            }) { _ in
                feedbackLabel.removeFromSuperview()
            }
        }
    }
    
    private func handleSwipe(direction: UISwipeGestureRecognizer.Direction) {
        let transform = direction == .right ? CGAffineTransform(translationX: 500, y: 0) : CGAffineTransform(translationX: -500, y: 0)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.movieImage.transform = transform
            self.movieImage.alpha = 0
        }) { _ in
            self.movieImage.transform = .identity
            self.movieImage.alpha = 1
            self.currentMovieIndex += 1
            self.displayCurrentMovie()
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
