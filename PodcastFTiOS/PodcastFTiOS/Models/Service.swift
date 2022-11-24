//
//  Service.swift
//  PodcastFTiOS
//
//  Created by aldybuana on 19/11/22.
//

import Foundation

protocol Service { }
extension Service {
    func searchPodcasts(q: String, completion: @escaping (Result<[Podcast], Error>) -> Void) {
        fatalError("func searchPodcasts(q:completion:) must be overridden")
    }
}
