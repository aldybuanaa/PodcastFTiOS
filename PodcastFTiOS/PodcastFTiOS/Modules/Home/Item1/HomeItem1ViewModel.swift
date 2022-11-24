//
//  HomeItem1ViewModel.swift
//  PodcastFTiOS
//
//  Created by aldybuana on 24/11/22.
//

import Foundation
import UIKit

class HomeItem1ViewModel {
    private var homeItem1: [HomeItem1] = []
    
    func fetchPodcasts(q: String, completion: @escaping (Result<Void, Error>) -> Void) {
        APIService.shared.fetchPodcastsInHomeItem1(q: q) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let homeItem1):
                    self?.homeItem1 = homeItem1
                    completion(.success(()))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    var numberOfHomeItem1: Int {
        return homeItem1.count
    }
    
    func homeItem1ImageUrl(at index: Int) -> String {
        return homeItem1[index].artworkUrl600
    }
    
    func homeItem1TrackName(at index: Int) -> String {
        return homeItem1[index].trackName
    }
    
    func homeItem1ArtistName(at index: Int) -> String {
        return homeItem1[index].artistName
    }
    
    func homeItem1(at index: Int) -> HomeItem1 {
        return homeItem1[index]
    }
}

extension HomeItem1ViewModel: ManagedObjectContextGetter { }
