import Foundation

struct Film: Codable, Hashable {
    let title: String
    let episodeId: Int
    let openingCrawl, director, producer, releaseDate: String
    let characters: [String]
    let url: URL
}
