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
    var firstMovie: Movie {
        return movieCatalog.first ?? moviesss
    }

    let moviesss = Movie(
        id: "bil", title: "Bora bill", image: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/npOnzAbLh6VOIu3naU5QaEcTepo.jpg", description: "Bad bunny", release_date: "1997", rt_score: "95"
    )

    init() {
        Task {
            await loadMovies()
        }
    }

    func loadMovies() async {
        do {
            movieCatalog = try await fecthMoviesFromAPI()
        } catch {
            print("Error in request films")
        }
    }
}
