//
//  MemesView.swift
//  demoLabTest
//
//  Created by Sukhitha Saparamadu on 2026-10-28.
//

import SwiftUI
import SwiftData

struct MemesView: View {
    @Environment(MemeStore.self) private var store
    @Query private var favMemes: [FavMeme]

    private var favIDs: Set<String> {
        Set(favMemes.map(\.memeID))
    }

    var body: some View {
        NavigationStack {
            Group {
                if store.memes.isEmpty {
                    ProgressView()
                } else {
                    List {
                        ForEach(store.memes) { meme in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(meme.name)
                                        .font(.headline)

                                    Text("Captions: \(meme.captions)")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }

                                Spacer()

                                Button {
                                    store.toggleFav(meme)
                                } label: {
                                    Image(systemName: favIDs.contains(meme.id) ? "heart.fill" : "heart")
                                        .padding()
                                }
                                .buttonStyle(.borderless)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Memes")
            .task {
                await store.fetchMemeData()
            }
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: FavMeme.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))

    MemesView()
        .environment(MemeStore(context: container.mainContext))
        .modelContainer(container)
}
