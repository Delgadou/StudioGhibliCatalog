//
//  NetworkCall.swift
//  StudioGhibliCatalog
//
//  Created by Henrique Delgado on 03/02/26.
//

import SwiftUI

struct Movie: Decodable, Identifiable, Hashable {
    let id: String
    let title: String
    let image: String
    let description: String
    let release_date: String
    let rt_score: String
}

func fecthMoviesFromAPI() async throws -> [Movie] {
    let url = URL(string: "https://ghibliapi.vercel.app/films")!

    let (data, _) = try await URLSession.shared.data(from: url)

    let movies = try JSONDecoder().decode([Movie].self, from: data)
    return movies
}
