
import Foundation

struct FlowerData: Codable {
    let query: Query
}

struct Query: Codable {
    let pageids: [String]
    let pages: [String: Pages]
}

struct Pages: Codable {
    let extract: String
    let thumbnail: Thumbnail
}

struct Thumbnail: Codable {
    let source: String
}
