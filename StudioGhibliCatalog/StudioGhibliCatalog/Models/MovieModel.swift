//
//  Movie.swift
//  StudioGhibliCatalog
//
//  Created by Henrique Delgado on 06/02/26.
//

struct Movie: Decodable, Identifiable, Hashable {
    let id: String
    let title: String
    let original_title_romanised: String
    let image: String
    let movie_banner: String
    let description: String
    let release_date: String
    let rt_score: String
    let running_time: String
    let director: String
    let producer: String
}
