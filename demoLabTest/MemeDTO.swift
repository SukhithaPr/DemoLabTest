//
//  MemeDTO.swift
//  demoLabTest
//
//  Created by Sukhitha Saparamadu on 2026-10-28.
//

import Foundation

struct Memes: Codable {
    let id: String
    let name: String
    let url: String
    let width: Int
    let height: Int
    let boxCount: Int
    let captions: Int

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case url
        case width
        case height
        case boxCount = "box_count"
        case captions
    }
}

struct Data: Codable {
    let memes: [Memes]
}

struct MemeDTO: Codable {
    let success: Bool
    let data: Data
}
