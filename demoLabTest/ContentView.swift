//
//  ContentView.swift
//  demoLabTest
//
//  Created by Sukhitha Saparamadu on 2026-10-28.
//

import SwiftUI

struct ContentView: View {
    @State private var memes: [Memes] = []
    @State private var selectedMeme: Memes?
    var body: some View {
        NavigationStack {
            Group {
                if memes.isEmpty {
                    ProgressView()
                } else {
                    List {
                        ForEach(memes) { meme in
                            Button {
                                selectedMeme = meme
                            } label: {
                                VStack(alignment: .leading) {
                                    Text(meme.name)
                                        .font(.headline)

                                    Text("Captions: \(meme.captions)")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .tint(.primary)
                        }
                    }
                }
            }
            .navigationTitle("Memes")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Meme Roulette", systemImage: "dice") {
                        selectedMeme = memes.randomElement()
                    }
                    .disabled(memes.isEmpty)
                }
            }
            .sheet(item: $selectedMeme) { meme in
                MemeDetailView(meme: meme)
            }
            .task {
                await fetchMemeData()
            }
        }
    }
    func fetchMemeData() async {
        guard let url = URL(string: "https://api.imgflip.com/get_memes") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        do {
            let (data, urlResponse) = try await URLSession.shared.data(for: request)
            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                return
            }
            guard (200...299).contains(httpResponse.statusCode)else {
                return
            }

            let decodedData = try JSONDecoder().decode(MemeDTO.self, from: data)
            memes = decodedData.data.memes

        } catch {
            print("Something went wrong, please try again later. \(error)")
        }
    }
}

#Preview {
    ContentView()
}
