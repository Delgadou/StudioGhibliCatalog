//
//  MoviesCatalogView.swift
//  StudioGhibliCatalog
//
//  Created by Henrique Delgado on 03/02/26.
//

import SwiftUI

struct MoviesCatalogView: View {
    @State var model: MoviesCatalogModel

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    LazyVStack(spacing: 16) {
                        ForEach(model.splitedArray[0]) { movie in
                            MovieBanner(movie: movie)
                        }
                    }

                    LazyVStack(spacing: 16) {
                        ForEach(model.splitedArray[1]) { movie in
                            MovieBanner(movie: movie)
                        }
                    }
                    .padding(.top, 40)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Movies")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.textPrimary)
                        .padding(.leading, 4)
                        .fixedSize(horizontal: true, vertical: false)
                }
                .sharedBackgroundVisibility(.hidden)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
    }
}

struct MovieBanner: View {
    let movie: Movie

    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: movie.image)) { image in
                ZStack(alignment: .topLeading)  {
                    image
                        .resizable()

                    HStack(spacing: 3) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(Color.yellow)
                            .font(.caption)

                        Text(movie.rt_score)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                    .padding(.horizontal, 7)
                    .padding(.vertical, 3)
                    .background(Color.white)
                    .cornerRadius(13)
                    .padding(.leading, 12)
                    .padding(.top, 14)
                }
            } placeholder: {
                Color.gray.opacity(0.2)
                    .modifier(ShimmerModifier())
            }
            .frame(maxWidth: .infinity)
            .frame(height: 265)
            .cornerRadius(16)

            Text(movie.title)
                .font(.headline)
                .foregroundStyle(.textPrimary)
                .padding(.top, 2)

            HStack {
                Text(movie.release_date)
                    .foregroundStyle(.textSecondary)

                Text("|")
                    .foregroundStyle(.textSecondary)
                    .padding(.bottom, 4)

                Text("\(movie.running_time)min")
                    .foregroundStyle(.textSecondary)
            }
        }
    }
}

#Preview {
    MoviesCatalogView(model: .init())
}

//.listStyle(.plain)
//.scrollContentBackground(.hidden)
//.navigationDestination(for: Destination.self) { movie in
//    switch movie {
//    case let .movieDetail(movie):
//        MovieDetailsView(movie: movie)
//    }
//}
