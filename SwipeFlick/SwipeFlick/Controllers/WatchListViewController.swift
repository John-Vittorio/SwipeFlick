//
//  WatchListViewController.swift
//  SwipeFlick
//
//  Created by Abdul Wahid on 5/23/25.
//

import UIKit

class WatchListViewController: UIViewController {
    
    // MARK: - Properties
    private var collectionView: UICollectionView!
    private var sampleMovies = ["Sample Movie 1", "Sample Movie 2", "Avengers", "Spider-Man", "Batman", "Iron Man"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateCollectionViewLayout()
    }
    
    // MARK: - Setup Methods
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(MovieCardCell.self, forCellWithReuseIdentifier: "MovieCardCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func updateCollectionViewLayout() {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        let screenWidth = collectionView.frame.width
        let isLandscape = screenWidth > collectionView.frame.height
        let cellsPerRow: CGFloat = isLandscape ? 3 : 2
        
        let horizontalPadding: CGFloat = 20
        let cellSpacing: CGFloat = 16
        
        let totalHorizontalSpacing = (horizontalPadding * 2) + (cellSpacing * (cellsPerRow - 1))
        let cellWidth = (screenWidth - totalHorizontalSpacing) / cellsPerRow
        let cellHeight = cellWidth * 1.4
        
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.minimumInteritemSpacing = cellSpacing
        layout.minimumLineSpacing = 24
        layout.sectionInset = UIEdgeInsets(top: 20, left: horizontalPadding, bottom: 20, right: horizontalPadding)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            self.updateCollectionViewLayout()
            self.collectionView.collectionViewLayout.invalidateLayout()
        })
    }
}

// MARK: - UICollectionViewDataSource
extension WatchListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sampleMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCardCell", for: indexPath) as! MovieCardCell
        cell.configure(with: sampleMovies[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension WatchListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = sampleMovies[indexPath.item]
        print("Tapped on: \(selectedMovie)")
        
        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
        impactFeedback.impactOccurred()
    }
}

// MARK: - Custom Movie Card Cell
class MovieCardCell: UICollectionViewCell {
    
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let titleBackground = UIView()
    private let cardBackground = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        cardBackground.translatesAutoresizingMaskIntoConstraints = false
        cardBackground.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        cardBackground.layer.cornerRadius = 16
        cardBackground.layer.borderWidth = 0.5
        cardBackground.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        
        cardBackground.layer.shadowColor = UIColor.black.cgColor
        cardBackground.layer.shadowOffset = CGSize(width: 0, height: 8)
        cardBackground.layer.shadowOpacity = 0.3
        cardBackground.layer.shadowRadius = 20
        
        if #available(iOS 13.0, *) {
            let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
            let blurView = UIVisualEffectView(effect: blurEffect)
            blurView.translatesAutoresizingMaskIntoConstraints = false
            blurView.layer.cornerRadius = 16
            blurView.clipsToBounds = true
            cardBackground.addSubview(blurView)
            
            NSLayoutConstraint.activate([
                blurView.topAnchor.constraint(equalTo: cardBackground.topAnchor),
                blurView.leadingAnchor.constraint(equalTo: cardBackground.leadingAnchor),
                blurView.trailingAnchor.constraint(equalTo: cardBackground.trailingAnchor),
                blurView.bottomAnchor.constraint(equalTo: cardBackground.bottomAnchor)
            ])
        }
        
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 12
        posterImageView.backgroundColor = UIColor.systemGray5.withAlphaComponent(0.5)
        
        titleBackground.translatesAutoresizingMaskIntoConstraints = false
        titleBackground.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        titleBackground.layer.cornerRadius = 10
        titleBackground.layer.borderWidth = 0.5
        titleBackground.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        
        if #available(iOS 13.0, *) {
            let titleBlurEffect = UIBlurEffect(style: .systemMaterialDark)
            let titleBlurView = UIVisualEffectView(effect: titleBlurEffect)
            titleBlurView.translatesAutoresizingMaskIntoConstraints = false
            titleBlurView.layer.cornerRadius = 10
            titleBlurView.clipsToBounds = true
            titleBackground.addSubview(titleBlurView)
            
            NSLayoutConstraint.activate([
                titleBlurView.topAnchor.constraint(equalTo: titleBackground.topAnchor),
                titleBlurView.leadingAnchor.constraint(equalTo: titleBackground.leadingAnchor),
                titleBlurView.trailingAnchor.constraint(equalTo: titleBackground.trailingAnchor),
                titleBlurView.bottomAnchor.constraint(equalTo: titleBackground.bottomAnchor)
            ])
        }
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        titleLabel.textColor = UIColor.white.withAlphaComponent(0.9)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byWordWrapping
        
        let filmIcon = UIImageView(image: UIImage(systemName: "film.fill"))
        filmIcon.translatesAutoresizingMaskIntoConstraints = false
        filmIcon.tintColor = UIColor.white.withAlphaComponent(0.15)
        filmIcon.contentMode = .scaleAspectFit
        
        contentView.addSubview(cardBackground)
        cardBackground.addSubview(posterImageView)
        posterImageView.addSubview(filmIcon)
        posterImageView.addSubview(titleBackground)
        titleBackground.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            cardBackground.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            posterImageView.topAnchor.constraint(equalTo: cardBackground.topAnchor, constant: 8),
            posterImageView.leadingAnchor.constraint(equalTo: cardBackground.leadingAnchor, constant: 8),
            posterImageView.trailingAnchor.constraint(equalTo: cardBackground.trailingAnchor, constant: -8),
            posterImageView.bottomAnchor.constraint(equalTo: cardBackground.bottomAnchor, constant: -8),
            
            filmIcon.centerXAnchor.constraint(equalTo: posterImageView.centerXAnchor),
            filmIcon.centerYAnchor.constraint(equalTo: posterImageView.centerYAnchor),
            filmIcon.widthAnchor.constraint(equalToConstant: 36),
            filmIcon.heightAnchor.constraint(equalToConstant: 36),
            
            titleBackground.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor, constant: 6),
            titleBackground.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: -6),
            titleBackground.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -6),
            titleBackground.heightAnchor.constraint(greaterThanOrEqualToConstant: 36),
            
            titleLabel.topAnchor.constraint(equalTo: titleBackground.topAnchor, constant: 6),
            titleLabel.leadingAnchor.constraint(equalTo: titleBackground.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: titleBackground.trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: titleBackground.bottomAnchor, constant: -6)
        ])
        
        setupHoverAnimation()
    }
    
    private func setupHoverAnimation() {
        let tapGesture = UITapGestureRecognizer()
        contentView.addGestureRecognizer(tapGesture)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: 0.1, delay: 0, options: .allowUserInteraction) {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self.cardBackground.layer.shadowOpacity = 0.5
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.2, delay: 0, options: .allowUserInteraction) {
            self.transform = .identity
            self.cardBackground.layer.shadowOpacity = 0.3
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        UIView.animate(withDuration: 0.2, delay: 0, options: .allowUserInteraction) {
            self.transform = .identity
            self.cardBackground.layer.shadowOpacity = 0.3
        }
    }
    
    func configure(with title: String) {
        titleLabel.text = title
    }
}
