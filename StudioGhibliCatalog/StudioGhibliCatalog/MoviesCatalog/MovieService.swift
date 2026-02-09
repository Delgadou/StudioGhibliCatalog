//
//  MovieService.swift
//  StudioGhibliCatalog
//
//  Created by Henrique Delgado on 07/02/26.
//

class MovieService {
    let baseURL = "https://ghibliapi.vercel.app/"
    let networkService: NetworkService

    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }

    func fetchMovies() async -> Result<[Movie], NetworkError> {
        await networkService.fetch(from: baseURL + "films")
    }
}
