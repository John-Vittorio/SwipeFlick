//
//  WatchlistManager.swift
//  SwipeFlick
//
//  Created by Abdul Wahid on 5/26/25.
//

import Foundation

class WatchlistManager {
    static let shared = WatchlistManager()
    
    private let userDefaultsKey = "userWatchlist"
    private var watchlist: [Movie] = []
    
    private init() {
        loadWatchlistFromUserDefaults()
    }
    
    func addToWatchlist(_ movie: Movie) {
        if !watchlist.contains(where: { $0.title == movie.title }) {
            watchlist.append(movie)
            saveWatchlistToUserDefaults()
        }
    }
    
    func removeFromWatchlist(_ movie: Movie) {
        watchlist.removeAll { $0.title == movie.title }
        saveWatchlistToUserDefaults()
    }
    
    func isInWatchlist(_ movie: Movie) -> Bool {
        return watchlist.contains { $0.title == movie.title }
    }
    
    func getWatchlist() -> [Movie] {
        return watchlist
    }
    
    func clearWatchlist() {
        watchlist.removeAll()
        saveWatchlistToUserDefaults()
    }
        
    private func saveWatchlistToUserDefaults() {
        let encoder = JSONEncoder()
        do {
            let encoded = try encoder.encode(watchlist)
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
            UserDefaults.standard.synchronize()
            print("Watchlist saved to UserDefaults. Count: \(watchlist.count)")
        } catch {
            print("Failed to encode watchlist: \(error)")
        }
    }
    
    private func loadWatchlistFromUserDefaults() {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey) else {
            print("No watchlist data found in UserDefaults")
            watchlist = []
            return
        }
        
        let decoder = JSONDecoder()
        do {
            watchlist = try decoder.decode([Movie].self, from: data)
            print("Watchlist loaded from UserDefaults. Count: \(watchlist.count)")
        } catch {
            print("Failed to decode watchlist: \(error)")
            watchlist = []
        }
    }
}
