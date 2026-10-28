//
//  MemeDetailView.swift
//  demoLabTest
//
//  Created by Subajanani Swaminathan on 2026-10-28.
//

import SwiftUI
import SwiftData

struct MemeDetailView: View {
    let meme: Memes

    @Environment(\.dismiss) private var dismiss
    @Environment(MemeStore.self) private var store
    @Query private var favMemes: [FavMeme]

    private var isFav: Bool {
        favMemes.contains { $0.memeID == meme.id }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .center, spacing: 16) {
                    Text(meme.name)
                        .font(.title2.bold())
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                    memeImage
                    favButton
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }

    private var memeImage: some View {
        AsyncImage(url: URL(string: meme.url)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
            case .failure:
                placeholder
            default:
                ProgressView()
            }
        }
        .clipShape(.rect(cornerRadius: 12))
        .frame(maxWidth: .infinity, minHeight: 250, alignment: .center)
        .accessibilityLabel(meme.name)
    }

    private var favButton: some View {
        Button {
            store.toggleFav(meme)
        } label: {
            Label(isFav ? "Remove from Favourites" : "Add to Favourites",
                  systemImage: isFav ? "heart.fill" : "heart")
        }
        .buttonStyle(.borderedProminent)
        .tint(isFav ? .red : .accentColor)
    }

    private var placeholder: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(.gray.opacity(0.2))
            .frame(height: 250)
            .overlay {
                Image(systemName: "photo")
                    .font(.largeTitle)
                    .foregroundStyle(.secondary)
            }
    }
}
