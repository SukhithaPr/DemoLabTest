//
//  MemeDTO.swift
//  demoLabTest
//
//  Created by Sukhitha Saparamadu on 2026-10-28.
//

import Foundation

struct Memes: Codable, Identifiable {
    let id: String
    let name: String
    let url: String
    let captions: Int
}

struct MemeData: Codable {
    let memes: [Memes]
}

struct MemeDTO: Codable {
    let success: Bool
    let data: MemeData
}
