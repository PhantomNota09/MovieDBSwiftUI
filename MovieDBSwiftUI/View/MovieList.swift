//
//  MovieList.swift
//  MovieDBSwiftUI
//
//  Created by Surya Rayala on 2/18/26.
//

import SwiftUI

struct MovieList: View {

    @State private var viewModel = MovieViewModel()
    
    var body: some View {
        list
    }
    
    var list: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading movies…")
                } else {
                    List(viewModel.movies, id: \.id) { movie in
                        NavigationLink {
                            MovieDetailView(movie: movie, viewModel: viewModel)
                        } label: {
                            MovieRowView(movie: movie, viewModel: viewModel)
                        }
                    }
                }
            }
            .navigationTitle("Movie List")
            .task {
                await viewModel.loadMovies()
            }
        }
    }
}

struct DefaultTextViewModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.secondary)
            .lineLimit(3)
    }
}

extension View {
    func defaultText() -> some View {
        modifier(DefaultTextViewModifier())
    }
}

// MARK: - Row View

/// A single row in the movie list
struct MovieRowView: View {
    let movie: MovieModel
    let viewModel: MovieViewModel

    var body: some View {
        HStack(spacing: 12) {
            // Poster image
            AsyncImage(url: viewModel.posterURL(for: movie)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 70, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 8))

            // Title, year, and overview
            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title ?? "Unknown Title")
                    .font(.headline)

                Text(viewModel.formattedReleaseYear(movie))
                    .font(.subheadline)
                    //.modifier(DefaultTextViewModifier)
                    .defaultText()

                Text(movie.overview ?? "No description available.")
                    .font(.caption)
                    .defaultText()
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    MovieList()
}
