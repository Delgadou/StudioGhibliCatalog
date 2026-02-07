//
//  MoviesCatalogModel.swift
//  StudioGhibliCatalog
//
//  Created by Henrique Delgado on 03/02/26.
//

import Foundation
import SwiftUI

enum Destination: Hashable {
    case movieDetails(Movie)
}

@MainActor
@Observable
class MoviesCatalogModel {
    enum State {
        case loading
        case loaded([Movie])
        case error(Error)
    }

    private let movieService: MovieService = MovieService()
//    var destination: Destination()
    var path = NavigationPath()
    var state: State = .loading {
        didSet {
            handleState()
        }
    }
    var movieCatalog: [Movie] = []
    var splitedArray: [[Movie]] {
        movieCatalog.enumerated().reduce(into: [[], []]) { result, item in
            result[item.offset % 2].append(item.element)
        }
    }

    init() {
        handleState()
    }

    func loadMovies() async {
        let result = await movieService.fetchMovies()

        switch result {
        case .success(let movies):
            self.state = .loaded(movies)
        case .failure(let error):
            self.state = .error(error)
        }
    }

    func handleState() {
        switch state {
        case .loading:
            Task {
                await loadMovies()
            }
        case .loaded(let movies):
            movieCatalog = movies
        case .error:
            break
        }
    }

    func navigateToDetails(movie: Movie) {
        path.append(Destination.movieDetails(movie))
//        destination = .movieDetails(movie)
    }
}
