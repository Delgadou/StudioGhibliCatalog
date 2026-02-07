//
//  MovieDetailsView.swift
//  StudioGhibliCatalog
//
//  Created by Henrique Delgado on 05/02/26.
//

import SwiftUI

struct MovieDetailsView: View {
    let movie: Movie

    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                AsyncImage(url: URL(string: movie.image)) { image in
                    image
                        .resizable()
                } placeholder: {
                    ProgressView()
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 200)

            Text(movie.title)
                .multilineTextAlignment(.leading)
                .font(.largeTitle)
                .bold()

            Text(movie.release_date)
                .multilineTextAlignment(.leading)
                .font(.title2)
                .bold()

            Text(movie.description)
                .multilineTextAlignment(.leading)
                .font(.headline)
                .bold()
                .padding(.top, 8)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.green)
    }
}

#Preview {
    MovieDetailsView(
        movie: .init(id: "12cfb892-aac0-4c5b-94af-521852e46d6a",
                     title: "Grave of the Fireflies",
                     image: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/qG3RYlIVpTYclR9TYIsy8p7m7AT.jpg",
                     description: "In the latter part of World War II, a boy and his sister, orphaned when their mother is killed in the firebombing of Tokyo, are left to survive on their own in what remains of civilian life in Japan. The plot follows this boy and his sister as they do their best to survive in the Japanese countryside, battling hunger, prejudice, and pride in their own quiet, personal battle.",
                     release_date: "1988", rt_score: "95", running_time: "2025")
    )
}
