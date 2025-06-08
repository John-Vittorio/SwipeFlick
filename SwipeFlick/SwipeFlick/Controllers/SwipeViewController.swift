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
    private var numMoviesSwipedRight = 0
    private var moviesSwipedRight: [Movie] = []
    private var swipedRight = 0;
    private var swipedLeft = 0;
    
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
        
        if UserDefaults.standard.integer(forKey: "swipedRight") > 0 {
            swipedRight = UserDefaults.standard.integer(forKey: "swipedRight")
        } else {
            UserDefaults.standard.set(swipedRight, forKey: "swipedRight")
        }
        
        if UserDefaults.standard.integer(forKey: "swipedLeft") > 0 {
            swipedLeft = UserDefaults.standard.integer(forKey: "swipedLeft")
        } else {
            UserDefaults.standard.set(swipedRight, forKey: "swipedLeft")
        }
        print(swipedLeft)
        print(swipedRight)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Reload movies when view appears to account for watchlist changes
        loadMovies()
        displayCurrentMovie()
    }
    
    @objc func handleSwipeLeft(_ gesture: UISwipeGestureRecognizer) {
        handleSwipe(direction: .left)
    }
    
    @objc func handleSwipeRight(_ gesture: UISwipeGestureRecognizer) {
        likeButtonTapped();
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
        print("Initial movies count: \(movies.count)")
        
        let genres = UserDefaults.standard.array(forKey: "userGenrePreferences") as? [String]
        let ratings = UserDefaults.standard.array(forKey: "userRatingPreferences") as? [String]
        let mediums = UserDefaults.standard.array(forKey: "userMediumPreferences") as? [String]
        let movieAge = UserDefaults.standard.array(forKey: "userMovieAgePreferences") as? [Int]
        
        print("User Preferences:")
        print("Genres: \(genres ?? [])")
        print("Ratings: \(ratings ?? [])")
        print("Mediums: \(mediums ?? [])")
        print("Movie Age: \(movieAge ?? [])")
        
        movies = movies.filter { movie in
            print("\nChecking movie: \(movie.title)")
            
            // First check if movie is already in watchlist - if so, skip it
            if WatchlistManager.shared.isInWatchlist(movie) {
                print("Movie is already in watchlist - skipping")
                return false
            }
            
            if let genres = genres, !genres.isEmpty {
                let hasMatchingGenre = movie.genre.contains { genre in
                    genres.contains(genre)
                }
                print("Genre match: \(hasMatchingGenre)")
                if !hasMatchingGenre {
                    return false
                }
            }
            
            if let ratings = ratings, !ratings.isEmpty {
                let hasMatchingRating = ratings.contains(movie.rating)
                print("Rating match: \(hasMatchingRating)")
                if !hasMatchingRating {
                    return false
                }
            }
            
            if let mediums = mediums, !mediums.isEmpty {
                let hasMatchingMedium = mediums.contains(movie.medium)
                print("Medium match: \(hasMatchingMedium)")
                if !hasMatchingMedium {
                    return false
                }
            }
            
            if let movieAge = movieAge, !movieAge.isEmpty {
                let currentYear = Calendar.current.component(.year, from: Date())
                let movieAgeInYears = currentYear - movie.releaseYear
                let isInRange = movieAge.contains { age in
                    movieAgeInYears <= age
                }
                print("Age match: \(isInRange) (Movie age: \(movieAgeInYears) years)")
                if !isInRange {
                    return false
                }
            }
            
            print("Movie passed all filters!")
            return true
        }
        
        print("\nFinal filtered movies count: \(movies.count)")
        
        // Reset current index if it's beyond the new filtered list
        if currentMovieIndex >= movies.count {
            currentMovieIndex = 0
        }
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
        
        if currentMovieIndex < movies.count {
            let movie = movies[currentMovieIndex]
            WatchlistManager.shared.addToWatchlist(movie)
            showWatchlistFeedback()
            moviesSwipedRight.append(movie)
        }
        
        handleSwipe(direction: .right)
        numMoviesSwipedRight += 1
        swipedRight += 1
        UserDefaults.standard.set(swipedRight, forKey: "swipedRight")
        print(UserDefaults.standard.integer(forKey: "swipedRight"))
        if (numMoviesSwipedRight == 5) {
            pickRandomMovie()
        }
    }
    
    private func pickRandomMovie() {
        let randomMovie = moviesSwipedRight.randomElement() ?? Movie.mockMovies[0]
        let alert = UIAlertController(title: "🍿 Movie matched!", message: "We think you might like \"\(randomMovie.title)\"!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        moviesSwipedRight.removeAll()
        numMoviesSwipedRight = 0
    }
    
    @objc private func dislikeButtonTapped() {
        handleSwipe(direction: .left)
        swipedLeft += 1
        UserDefaults.standard.set(swipedLeft, forKey: "swipedLeft")
        print(UserDefaults.standard.integer(forKey: "swipedLeft"))
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
