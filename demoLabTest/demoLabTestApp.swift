//
//  demoLabTestApp.swift
//  demoLabTest
//
//  Created by Sukhitha Saparamadu on 2026-10-28.
//

import SwiftUI
import SwiftData

@main
struct demoLabTestApp: App {
    private let container: ModelContainer
    @State private var memeStore: MemeStore

    init() {
        do {
            container = try ModelContainer(for: FavMeme.self)
            _memeStore = State(initialValue: MemeStore(context: container.mainContext))
        } catch {
            fatalError("Could not create Database: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(memeStore)
        }
        .modelContainer(container)
    }
}
