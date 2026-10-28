//
//  MemeStore.swift
//  demoLabTest
//
//  Created by Sukhitha Saparamadu on 2026-10-28.
//

import Foundation
import Observation
import SwiftData

@MainActor
@Observable
final class MemeStore {
    private let context: ModelContext
    private(set) var memes: [Memes] = []

    init(context: ModelContext) {
        self.context = context
    }

    func toggleFav(_ meme: Memes) {
        let memeID = meme.id
        let descriptor = FetchDescriptor<FavMeme>(predicate: #Predicate { $0.memeID == memeID })

        if let existing = try? context.fetch(descriptor).first {
            context.delete(existing)
        } else {
            context.insert(FavMeme(memeID: meme.id, name: meme.name, url: meme.url))
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
