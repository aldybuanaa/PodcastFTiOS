//
//  HomeItem2.swift
//  PodcastFTiOS
//
//  Created by aldybuana on 19/11/22.
//

import Foundation

protocol HomeItem2 {
    var trackId: Int { get }
    var trackName: String { get }
    var trackCount: Int { get }
    var artistName: String { get }
    var artworkUrl100: String { get }
    var feedUrl: String { get }
    var releaseDate: String { get }
}

struct HomeItem2_: Decodable, HomeItem2 {
    var trackId: Int
    var trackName: String
    var trackCount: Int
    var artistName: String
    var artworkUrl100: String
    var feedUrl: String
    var releaseDate: String

    enum CodingKeys: String, CodingKey {
        case trackId
        case trackName
        case trackCount
        case artistName
        case artworkUrl100
        case feedUrl
        case releaseDate
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.trackId = try container.decodeIfPresent(Int.self, forKey: .trackId) ?? 0
        self.trackName = try container.decodeIfPresent(String.self, forKey: .trackName) ?? ""
        self.trackCount = try container.decodeIfPresent(Int.self, forKey: .trackCount) ?? 0
        self.artistName = try container.decodeIfPresent(String.self, forKey: .artistName) ?? ""
        self.artworkUrl100 = try container.decodeIfPresent(String.self, forKey: .artworkUrl100) ?? ""
        self.feedUrl = try container.decodeIfPresent(String.self, forKey: .feedUrl) ?? ""
        self.releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate) ?? ""
    }
}
