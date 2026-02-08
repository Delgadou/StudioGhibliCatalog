//
//  MoviesCatalogModel.swift
//  StudioGhibliCatalog
//
//  Created by Henrique Delgado on 03/02/26.
//

import Foundation
import SwiftUI
import SwiftNavigation

@MainActor
@Observable
class MoviesCatalogModel {
    // MARK: Enums
    @CasePathable
    enum Destination {
        case movieDetails(MovieDetailsModel)
    }

    enum State {
        case loading
        case loaded([Movie])
        case error(Error)
    }


    // MARK: Properties
    private let movieService: MovieService = MovieService()
    var movieCatalog: [Movie] = []
    var splitedArray: [[Movie]] {
        movieCatalog.enumerated().reduce(into: [[], []]) { result, item in
            result[item.offset % 2].append(item.element)
        }
    }

    var destination: Destination? {
        didSet {
            bindDestination()
        }
    }
    var state: State = .loading {
        didSet {
            handleState()
        }
    }

    init() {
        handleState()
    }

    // MARK: Methods
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
        destination = .movieDetails(MovieDetailsModel(movie: movie))
    }

    func bindDestination() {
        switch destination {
        case .movieDetails(let model):
            model.onClose = { [weak self] in
                self?.destination = nil
            }
        case nil:
            break
        }
    }
}
