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
            GeometryReader { geometry in
                List {
                    ForEach(model.movieCatalog) { movie in
                        NavigationLink(value: Destination.movieDetail(movie)) {
                            ZStack {
                                AsyncImage(url: URL(string: movie.image)) { image in
                                    image
                                        .resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                VStack {
                                    HStack {
                                        Text(movie.title)
                                            .font(.title)
                                            .foregroundStyle(Color.white)
                                            .frame(alignment: .leading)
                                            .bold()

                                        Spacer()

                                        HStack {
                                            Image(systemName: "arrow.right")
                                                .foregroundStyle(Color.white)
                                                .bold()
                                        }
                                    }

                                    Spacer()

                                    HStack {
                                        Text(movie.release_date)
                                            .font(.title2)
                                            .bold()
                                            .foregroundStyle(Color.white)

                                        Spacer()
                                    }
                                }
                            }
                            .padding(.leading)
                            .frame(width: geometry.size.width, height: 250)
                        }
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .navigationTitle("Ghibli Catalog")
                .navigationDestination(for: Destination.self) { movie in
                    switch movie {
                    case let .movieDetail(movie):
                        MovieDetailsView(movie: movie)
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
        }
    }
}

#Preview {
    MoviesCatalogView(model: .init())
}
