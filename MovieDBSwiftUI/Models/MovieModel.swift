//
//  MovieModel.swift
//  MovieDBSwiftUI
//
//  Created by Surya Rayala on 2/18/26.
//

import Foundation

// MARK: - API Response Model

/// Represents the response from the API
struct MovieResponse: Decodable {
    let results: [MovieModel]
}

// MARK: - Movie Model

/// Represents a movie with all its information
struct MovieModel: Decodable {
    let id: Int?
    let title: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double?
    let voteCount: Int?
    let releaseDate: String?
    let genreIds: [Int]?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case popularity
        case posterPath    = "poster_path"
        case backdropPath  = "backdrop_path"
        case voteAverage   = "vote_average"
        case voteCount     = "vote_count"
        case releaseDate   = "release_date"
        case genreIds      = "genre_ids"
    }
}
