//
//  NetworkManager.swift
//  MovieDBSwiftUI
//
//  Created by Surya Rayala on 2/18/26.
//

import Foundation

// MARK: - Network Manager

/// Responsible for fetching data from the server
class NetworkManager {

    func getDataFromServer(url: String) async -> [MovieModel] {

        // Make sure the URL is valid
        guard let serverURL = URL(string: url) else {
            print("Log: Invalid URL")
            return []
        }

        do {
            // Fetch raw data from the server
            let (data, response) = try await URLSession.shared.data(from: serverURL)

            // Make sure we got a 200 OK response
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                print("Log: Unexpected status code \(httpResponse.statusCode)")
                return []
            }

            // Decode the JSON into our model
            let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
            return movieResponse.results

        } catch {
            print("Log: Error fetching data — \(error.localizedDescription)")
            return []
        }
    }
}
