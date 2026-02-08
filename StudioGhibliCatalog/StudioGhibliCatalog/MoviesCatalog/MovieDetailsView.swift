//
//  MovieDetailsView.swift
//  StudioGhibliCatalog
//
//  Created by Henrique Delgado on 05/02/26.
//

import SwiftUI

struct MovieDetailsView: View {
    @State var model: MovieDetailsModel

    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                AsyncImage(url: URL(string: model.movie.movie_banner)) { image in
                    image
                        .resizable()
                } placeholder: {
                    Color.gray
                        .modifier(ShimmerModifier())
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 200)
            .cornerRadius(13)

            Text(model.movie.title)
                .multilineTextAlignment(.leading)
                .font(.largeTitle)
                .bold()

            Text(model.movie.release_date)
                .multilineTextAlignment(.leading)
                .font(.title2)
                .bold()

            Text(model.movie.description)
                .multilineTextAlignment(.leading)
                .font(.headline)
                .bold()
                .padding(.top, 8)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    model.close()
                } label: {
                    HStack {
                        Image(systemName: "xmark")
                    }
                }
            }
        })
    }
}

#Preview {
    MovieDetailsView(
        model: MovieDetailsModel(movie: .init(id: "12cfb892-aac0-4c5b-94af-521852e46d6a",
                     title: "Grave of the Fireflies",
                     image: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/qG3RYlIVpTYclR9TYIsy8p7m7AT.jpg",
                     movie_banner:"https://image.tmdb.org/t/p/original/vkZSd0Lp8iCVBGpFH9L7LzLusjS.jpg",
                     description: "In the latter part of World War II, a boy and his sister, orphaned when their mother is killed in the firebombing of Tokyo, are left to survive on their own in what remains of civilian life in Japan. The plot follows this boy and his sister as they do their best to survive in the Japanese countryside, battling hunger, prejudice, and pride in their own quiet, personal battle.",
                     release_date: "1988", rt_score: "95", running_time: "2025")
        )
    )
}
