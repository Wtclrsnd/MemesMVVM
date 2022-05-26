//
//  MemesModel.swift
//  MemesMVVM
//
//  Created by Emil Shpeklord on 25.05.2022.
//

import Foundation

// MARK: - Meme
struct Meme: Codable {
    let success: Bool
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let memes: [MemeElement]
}

// MARK: - MemeElement
struct MemeElement: Codable {
    let id, name: String
    let url: String
    let width, height, boxCount: Int

    enum CodingKeys: String, CodingKey {
        case id, name, url, width, height
        case boxCount = "box_count"
    }
}
