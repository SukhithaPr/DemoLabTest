//
//  FavView.swift
//  demoLabTest
//
//  Created by Sukhitha Saparamadu on 2026-10-28.
//

import SwiftUI
import SwiftData

struct FavView: View {
    @Query private var favMemes: [FavMeme]

    var body: some View {
        Text("\(favMemes.count) favourite memes")
            .font(.title)
            .bold()
    }
}

#Preview {
    FavView()
        .modelContainer(for: FavMeme.self, inMemory: true)
}
