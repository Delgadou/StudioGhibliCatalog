//
//  ShimmerEffect.swift
//  StudioGhibliCatalog
//
//  Created by Henrique Delgado on 06/02/26.
//

import SwiftUI

struct ShimmerModifier: ViewModifier {
    @State var isInitialState: Bool = true

    public func body(content: Content) -> some View {
        content
            .mask {
                LinearGradient(
                    colors: [Color.white.opacity(0.5), Color.white.opacity(0.4), Color.white.opacity(0.5)],
                    startPoint: (isInitialState ? .init(x: -2, y: -2) : .init(x: 1, y: 1)),
                    endPoint: (isInitialState ? .init(x: 1, y: 0.2) : .init(x: 1.3, y: 1.3))
                )
            }
            .animation(.linear(duration: 2).repeatForever(autoreverses: false), value: isInitialState)
            .onAppear() {
                isInitialState = false
            }
    }
}

struct teste: View {
    var body: some View {
        VStack {
            Color.gray
        }
        .frame(width: 250, height: 450)
        .modifier(ShimmerModifier())
    }
}

#Preview {
    teste()
}
