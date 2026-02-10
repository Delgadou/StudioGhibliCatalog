//
//  MovieDetailsModel.swift
//  StudioGhibliCatalog
//
//  Created by Henrique Delgado on 08/02/26.
//

import SwiftUI
import CasePaths

@Observable
@MainActor
class MovieDetailsModel: Identifiable {
    // MARK: Properties
    let movie: Movie
    var isDescriptionExpanded = false
    var onClose: (() -> Void)?
    var detailItem: [DetailItem] {
        [
            DetailItem(type: .duration, value: movie.running_time),
            DetailItem(type: .rating, value: movie.rt_score),
            DetailItem(type: .producer, value: movie.producer)
        ]
    }

    enum DetailType {
        case duration
        case rating
        case producer

        var title: String {
            switch self {
            case .duration: return "Duration"
            case .rating: return "Rating"
            case .producer: return "Producer"
            }
        }
    }
    
    struct DetailItem: Identifiable {
        let id = UUID()
        let type: DetailType
        let value: String
    }

    init(movie: Movie) {
        self.movie = movie
    }

    // MARK: Methods
    func close() {
        onClose?()
    }
}
