//
//  StudioGhibliCatalogApp.swift
//  StudioGhibliCatalog
//
//  Created by Henrique Delgado on 03/02/26.
//

import SwiftUI

@main
struct StudioGhibliCatalogApp: App {
    @State var model = MoviesCatalogModel()

    var body: some Scene {
        WindowGroup {
            MoviesCatalogView(model: model)
        }
    }
}
