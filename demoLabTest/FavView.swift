//
//  FavView.swift
//  demoLabTest
//
//  Created by Sukhitha Saparamadu on 2026-10-28.
//

import SwiftUI
import SwiftData

struct FavView: View {
    @Environment(MemeStore.self) private var store
    @Query(sort: \FavMeme.createdAt, order: .reverse) private var favMemes: [FavMeme]

    var body: some View {
        NavigationStack {
            Group {
                if favMemes.isEmpty {
                    ContentUnavailableView("No Favourites",
                                           systemImage: "heart",
                                           description: Text("Tap the heart on a meme to add it here."))
                } else {
                    List {
                        ForEach(favMemes) { fav in
                            HStack {
                                Text(fav.name)

                                Spacer()

                                Button {
                                    store.removeFav(fav)
                                } label: {
                                    Image(systemName: "heart.fill")
                                        .padding()
                                }
                                .buttonStyle(.borderless)
                            }
                        }
                    }
                }
            }
            .navigationTitle("\(favMemes.count) Favourites")
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: FavMeme.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))

    FavView()
        .environment(MemeStore(context: container.mainContext))
        .modelContainer(container)
}
