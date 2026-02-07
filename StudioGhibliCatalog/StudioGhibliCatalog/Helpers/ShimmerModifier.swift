//
//  ShimmerEffect.swift
//  StudioGhibliCatalog
//
//  Created by Henrique Delgado on 06/02/26.
//

import SwiftUI

struct ShimmerModifier: ViewModifier {
    @State private var startPoint = UnitPoint(x: -1.8, y: -1.2)
    @State private var endPoint = UnitPoint(x: 0, y: -0.2)
    @State private var isVisible = false

    func body(content: Content) -> some View {
        content
            .overlay(
                LinearGradient(
                    colors: [
                        Color.gray.opacity(0.4),
                        Color.white.opacity(0.7),
                        Color.gray.opacity(0.4)
                    ],
                    startPoint: startPoint,
                    endPoint: endPoint
                )
                .mask(content)
                .onChange(of: isVisible) { visible, _ in
                    if visible {
                        withAnimation(
                            .linear(duration: 1.5)
                            .repeatForever(autoreverses: false)
                        ) {
                            startPoint = UnitPoint(x: 1, y: 1.2)
                            endPoint = UnitPoint(x: 2.2, y: 2.4)
                        }
                    }
                }
            )
            .onAppear { isVisible = true }
            .onDisappear { isVisible = false }
            .clipped()
    }
}
