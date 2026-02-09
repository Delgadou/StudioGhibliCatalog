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
        ScrollView {
            VStack(alignment: .leading) {
                ZStack(alignment: .bottom) {
                    AsyncImage(url: URL(string: model.movie.movie_banner)) { image in
                        image
                            .resizable()
                    } placeholder: {
                        Color.gray
                            .modifier(ShimmerModifier())
                    }
                    
                    LinearGradient(
                        colors: [
                            Color(uiColor: .systemBackground).opacity(0),
                            Color(uiColor: .systemBackground).opacity(0.2),
                            Color(uiColor: .systemBackground).opacity(0.8),
                            Color(uiColor: .systemBackground),
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 75)
                    
                    VStack {
                        HStack {
                            Button {
                                model.close()
                            } label: {
                                Image(systemName: "xmark")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundStyle(Color(uiColor: .systemBackground)).colorInvert()
                                    .frame(width: 44, height: 44)
                                    .background(
                                        Circle()
                                            .foregroundStyle(Color(uiColor: .systemBackground).opacity(0.3))
                                    )
                            }
                            .padding(16)
                            Spacer()
                        }
                        Spacer()
                    }
                }
                .ignoresSafeArea()
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                
                HStack(alignment: .top, spacing: 16) {
                    AsyncImage(url: URL(string: model.movie.image)) { image in
                        image
                            .resizable()
                    } placeholder: {
                        Color.gray
                            .modifier(ShimmerModifier())
                    }
                    .frame(width: 125, height: 193)
                    .cornerRadius(13)
                    .clipped()
                    .offset(y: -40)
                    
                    VStack(alignment: .leading) {
                        Text(model.movie.title)
                            .font(.title2)
                            .foregroundStyle(.primary)
                            .bold()
                        
                        Text(model.movie.original_title_romanised)
                            .font(.body)
                            .foregroundStyle(.secondary)
                        
                        HStack {
                            Text(model.movie.release_date)
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                            
                            Circle()
                                .frame(width: 3, height: 3)
                                .foregroundStyle(.secondary)
                            
                            Text("DIRECTED BY")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.top)
                        Text(model.movie.director)
                            .font(.headline)
                            .foregroundStyle(.primary)
                    }
                    .padding(.top)
                }
                
                VStack {
                    ZStack {
                        Text(model.movie.description)
                            .font(.callout)
                            .foregroundStyle(.primary)
                            .multilineTextAlignment(.leading)
                            .lineLimit(model.isDescriptionExpanded ? nil : 4)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom)
                        
                        LinearGradient(
                            colors: [
                                Color(uiColor: .systemBackground).opacity(0),
                                Color(uiColor: .systemBackground).opacity(0.2),
                                Color(uiColor: .systemBackground).opacity(0.8),
                                Color(uiColor: .systemBackground),
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 75)
                        .opacity(model.isDescriptionExpanded ? 0 : 1)
                    }
                    .animation(.easeInOut, value: model.isDescriptionExpanded)
                    .onTapGesture { _ in
                        model.isDescriptionExpanded.toggle()
                    }
                    
                    Divider()
                        .ignoresSafeArea()
                    
                    List {
                        ForEach(model.detailItem) { item in
                            HStack {
                                Text(item.type.title)
                                    .font(.body)
                                
                                Spacer()
                                
                                Text(item.type == .duration ? movieDuration(minutes: item.value) : item.value)
                                    .font(.body)
                                    .foregroundStyle(.secondary)
                            }
                        }.ignoresSafeArea()
                    }
                    .listStyle(.plain)
                    .frame(height: 200)
                    .ignoresSafeArea()
                }
                .offset(y: -26)
                
                Spacer()
            }
            .safeAreaPadding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    func movieDuration(minutes: String) -> String {
        let minutesInt = Int(minutes) ?? 0
        let hours = minutesInt / 60
        let minutesRemaining = minutesInt % 60

        return "\(hours)h \(minutesRemaining)m"
    }
}

#Preview {
    SheetPreview()
}

struct SheetPreview: View {
    @State private var showSheet = true

    var body: some View {
        Color.clear
            .sheet(isPresented: $showSheet) {
                NavigationStack {
                    MovieDetailsView(
                        model: MovieDetailsModel(
                            movie: .init(
                                id: "12cfb892-aac0-4c5b-94af-521852e46d6a",
                                title: "Grave of the Fireflies",
                                original_title_romanised: "Hotaru no haka",
                                image: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/qG3RYlIVpTYclR9TYIsy8p7m7AT.jpg",
                                movie_banner:"https://image.tmdb.org/t/p/w533_and_h300_bestv2/3cyjYtLWCBE1uvWINHFsFnE8LUK.jpg",
                                description: "Two sisters move to the country with their father in order to be closer to their hospitalized mother, and discover the surrounding trees are inhabited by Totoros, magical spirits of the forest. When the youngest runs away from home, the older sister seeks help from the spirits to find her.",
                                release_date: "1988",
                                rt_score: "95",
                                running_time: "104",
                                director: "Isao Takahata",
                                producer: "Toru Hara",
                            )
                        )
                    )
                }
            }
    }
}
