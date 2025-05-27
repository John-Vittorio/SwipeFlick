//
//  WatchlistManager.swift
//  SwipeFlick
//
//  Created by Abdul Wahid on 5/26/25.
//

import Foundation

class WatchlistManager {
    static let shared = WatchlistManager()
    
    private var watchlist: [Movie] = []
    
    private init() {}
    
    func addToWatchlist(_ movie: Movie) {
        if !watchlist.contains(where: { $0.title == movie.title }) {
            watchlist.append(movie)
        }
    }
    
    func removeFromWatchlist(_ movie: Movie) {
        watchlist.removeAll { $0.title == movie.title }
    }
    
    func isInWatchlist(_ movie: Movie) -> Bool {
        return watchlist.contains { $0.title == movie.title }
    }
    
    func getWatchlist() -> [Movie] {
        return watchlist
    }
    
    func clearWatchlist() {
        watchlist.removeAll()
    }
}
