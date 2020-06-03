// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Films
struct Films: Decodable, Hashable {
    let count: Int
    let results: [FilmResult]
}

// MARK: - FilmResult
struct FilmResult: Decodable, Hashable {
    let title: String
    let episodeId: Int
    let url: URL
}
