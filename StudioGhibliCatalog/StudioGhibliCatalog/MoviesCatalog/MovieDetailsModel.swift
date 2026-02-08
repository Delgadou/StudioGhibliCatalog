//
//  MovieDetailsModel.swift
//  StudioGhibliCatalog
//
//  Created by Henrique Delgado on 08/02/26.
//

import SwiftUI
import CasePaths

//Investigar por que final class
@Observable
@MainActor
final class MovieDetailsModel: Identifiable {
    var movie: Movie
    var onClose: (() -> Void)?

    init(movie: Movie) {
        self.movie = movie
    }

    func close() {
        onClose?()
    }
}
