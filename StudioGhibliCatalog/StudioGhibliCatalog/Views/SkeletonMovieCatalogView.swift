//
//  SkeletonMovieCatalogView.swift
//  StudioGhibliCatalog
//
//  Created by Henrique Delgado on 09/02/26.
//

import SwiftUI

struct SkeletonMovieCatalogView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            HStack(alignment: .top, spacing: 16) {
                LazyVStack(spacing: 16) {
                    ForEach(0..<3, id: \.self) { _ in
                        SkeletonMovieBanner()
                    }
                }

                LazyVStack(spacing: 16) {
                    ForEach(0..<3, id: \.self) { _ in
                        SkeletonMovieBanner()
                    }
                }
                .padding(.top, 40)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text("Movies")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.primary)
                    .padding(.leading, 4)
                    .fixedSize(horizontal: true, vertical: false)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

struct SkeletonMovieBanner: View {
    var body: some View {
        VStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gray)
                .frame(maxWidth: .infinity)
                .frame(height: 265)
                .modifier(ShimmerModifier())

            RoundedRectangle(cornerRadius: 4)
                .fill(Color.gray)
                .frame(height: 16)
                .frame(maxWidth: .infinity)
                .padding(.top, 2)
                .modifier(ShimmerModifier())

            HStack(spacing: 8) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray)
                    .frame(width: 50, height: 12)

                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray)
                    .frame(width: 60, height: 12)
            }
            .padding(.top, 4)
            .modifier(ShimmerModifier())
        }
    }
}
