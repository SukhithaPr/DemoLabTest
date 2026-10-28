//
//  ContentView.swift
//  demoLabTest
//
//  Created by Sukhitha Saparamadu on 2026-10-28.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            MemesView()
                .tabItem {
                    Label("Memes", systemImage: "photo.on.rectangle")
                }

            FavView()
                .tabItem {
                    Label("Favourites", systemImage: "heart.fill")
                }
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: FavMeme.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))

    ContentView()
        .environment(MemeStore(context: container.mainContext))
        .modelContainer(container)
}
