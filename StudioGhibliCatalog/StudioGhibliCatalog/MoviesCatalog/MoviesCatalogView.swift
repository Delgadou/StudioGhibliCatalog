//
//  MoviesCatalogView.swift
//  StudioGhibliCatalog
//
//  Created by Henrique Delgado on 03/02/26.
//

import SwiftUI
import SwiftUINavigation

struct MoviesCatalogView: View {
    @State var model: MoviesCatalogModel

    var body: some View {
        NavigationStack {
            switch model.state {
            case .loading:
                ProgressView()
            case .loaded:
                CatalogView(model: $model)
            case .error(let error):
                ErrorView(error: error, onTryAgain: model.tryLoadMoviesAgain)
            }
        }
    }
}

struct CatalogView: View {
    @Binding var model: MoviesCatalogModel

    var body: some View {
        ScrollView(showsIndicators: false) {
            HStack(alignment: .top, spacing: 16) {
                LazyVStack(spacing: 16) {
                    ForEach(model.splitedArray[0]) { movie in
                        MovieBanner(movie: movie)
                            .onTapGesture { _ in
                                model.navigateToDetails(movie: movie)
                            }
                    }
                }
                LazyVStack(spacing: 16) {
                    ForEach(model.splitedArray[1]) { movie in
                        MovieBanner(movie: movie)
                            .onTapGesture { _ in
                                model.navigateToDetails(movie: movie)
                            }
                    }
                }
                .padding(.top, 40)
            }
            .sheet(item: $model.destination.movieDetails, onDismiss: {
                model.destination = nil
            }) { model in
                NavigationStack {
                    MovieDetailsView(model: model)
                }
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
                Color.gray
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

struct ErrorView: View {
    let error: Error
    let onTryAgain: (() -> Void)?

    var body: some View {
        VStack {
            Text("Error")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.red)

            Text(error.localizedDescription)

            Button {
                //Apertar botao
            } label: {
                Text("Try again")
                    .bold()
                    .foregroundStyle(Color.white)
                    .frame(width: 150, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    MoviesCatalogView(model: .init())
}
