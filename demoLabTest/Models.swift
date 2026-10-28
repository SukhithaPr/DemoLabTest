//
//  Models.swift
//  demoLabTest
//
//  Created by Sukhitha Saparamadu on 2026-10-28.
//

import Foundation
import SwiftData

@Model
final class FavMeme {
    @Attribute(.unique) var memeID: String
    var name: String
    var url: String
    var createdAt: Date

    init(memeID: String,
         name: String,
         url: String,
         createdAt: Date = .now) {
        self.memeID = memeID
        self.name = name
        self.url = url
        self.createdAt = createdAt
    }
}
