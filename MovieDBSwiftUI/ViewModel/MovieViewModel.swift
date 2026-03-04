//
//  MovieViewModel.swift
//  MovieDBSwiftUI
//
//  Created by Surya Rayala on 2/18/26.
//

import Foundation
import Observation

// MARK: - Movie View Model

/// Holds the list of movies and loads them from the network.
/// @Observable - so SwiftUI views automatically update when movies changes.
@Observable
class MovieViewModel {

    // MARK: - Properties

    /// The list of movies shown in the UI
    var movies: [MovieModel] = []

    /// Tracks whether a network request is in progress
    var isLoading: Bool = false

    private let service = NetworkManager()

    // MARK: - Data Loading

    /// Fetches movies from the server
    func loadMovies() async {
        isLoading = true
        movies = await service.getDataFromServer(url: Server.MovieDataUrl.rawValue)
        isLoading = false
    }

    // MARK: - Formatting Helpers

    func posterURL(for movie: MovieModel) -> URL? {
        guard let path = movie.posterPath else { return nil }
        return URL(string: Server.ImageBaseUrl.rawValue + path)
    }

    func formattedRating(_ movie: MovieModel) -> String {
        guard let rating = movie.voteAverage else { return "N/A" }
        return String(format: "%.1f / 10", rating)
    }

    func formattedReleaseYear(_ movie: MovieModel) -> String {
        guard let date = movie.releaseDate, date.count >= 4 else { return "Unknown" }
        return String(date.prefix(4))
    }
}
