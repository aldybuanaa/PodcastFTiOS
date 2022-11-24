//
//  SearchResponse.swift
//  PodcastFTiOS
//
//  Created by aldybuana on 18/11/22.
//

import Foundation

struct SearchResponse: Decodable {
    let count: Int
    let results: [Podcast]
    let resultHomeItem1: [HomeItem1]
    let resultHomeItem2: [HomeItem2]
    
    enum CodingKeys: String, CodingKey {
        case count = "resultCount"
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decodeIfPresent(Int.self, forKey: .count) ?? 0
        results = try container.decodeIfPresent([Podcast_].self, forKey: .results) ?? []
        resultHomeItem1 = try container.decodeIfPresent([HomeItem1_].self, forKey: .results) ?? []
        resultHomeItem2 = try container.decodeIfPresent([HomeItem2_].self, forKey: .results) ?? []
    }
}
