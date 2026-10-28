//
//  MemeDetailView.swift
//  demoLabTest
//
//  Created by Subajanani Swaminathan on 2026-10-28.
//

import SwiftUI

struct MemeDetailView: View {
    let meme: Memes

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .center, spacing: 16) {
                    memeImage
                    // TODO: Add favourite (heart) button
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .navigationTitle(meme.name)
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
