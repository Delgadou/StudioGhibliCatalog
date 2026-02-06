//
//  MoviesCatalogModel.swift
//  StudioGhibliCatalog
//
//  Created by Henrique Delgado on 03/02/26.
//
import Foundation
import SwiftUI

enum Destination: Hashable {
    case movieDetail(Movie)
}

@MainActor
@Observable
class MoviesCatalogModel {
    var destination: Destination?
    var movieCatalog: [Movie] = []
    var errorMessage: String?

    var splitedArray: [[Movie]] {
        movieCatalog.enumerated().reduce(into: [[], []]) { result, item in
            result[item.offset % 2].append(item.element)
        }
    }
    var firstMovie: Movie {
        return movieCatalog.first ?? moviesss
    }

    let moviesss = Movie(
        id: "bil", title: "Bora bill", image: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/npOnzAbLh6VOIu3naU5QaEcTepo.jpg", description: "Bad bunny", release_date: "1997", rt_score: "95", running_time: "2025"
    )

    init() {
        Task {
            await loadMovies()
        }
    }

    func loadMovies() async {
        let result = await NetworkService().fetchMovies()

        switch result {
        case .success(let movies):
            self.movieCatalog = movies
            self.errorMessage = nil
        case .failure(let error):
            self.errorMessage = error.description
        }
    }
}
