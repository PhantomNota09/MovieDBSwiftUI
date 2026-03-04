//
//  MovieDetailView.swift
//  MovieDBSwiftUI
//
//  Created by Surya Rayala on 2/19/26.
//


import SwiftUI

// MARK: - Detail View

/// Full-screen detail for a single movie
struct MovieDetailView: View {
    let movie: MovieModel
    let viewModel: MovieViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Poster
                AsyncImage(url: viewModel.posterURL(for: movie)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Color.gray.opacity(0.3)
                        .frame(height: 300)
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)

                // Title
                Text(movie.title ?? "Unknown Title")
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                // Rating and year side by side
                HStack(spacing: 20) {
                    Label(viewModel.formattedRating(movie), systemImage: "star.fill")
                        .foregroundStyle(.yellow)

                    Label(viewModel.formattedReleaseYear(movie), systemImage: "calendar")
                        .foregroundStyle(.secondary)
                }
                .font(.subheadline)

                // Overview
                Text(movie.overview ?? "No description available.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)

                // YouTube Button
                Button(action: openYouTube) {
                    HStack {
                        Text("Watch on YouTube")
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                }
                .padding(.horizontal)
                .padding(.top, 8)

                Spacer()
            }
            .padding(.top)
        }
        .navigationTitle(movie.title ?? "Movie")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func openYouTube() {
        UIApplication.shared.open(URL(string: "https://www.youtube.com")!) //if app exists then we can you youtube://
    }
}
