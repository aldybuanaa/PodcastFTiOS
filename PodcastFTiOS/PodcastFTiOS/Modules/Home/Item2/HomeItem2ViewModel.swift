//
//  HomeItem2ViewModel.swift
//  PodcastFTiOS
//
//  Created by aldybuana on 24/11/22.
//

import Foundation
import UIKit

class HomeItem2ViewModel {
    private var homeItem2: [HomeItem2] = []
    let dateFormatterEx = Date()
    
    func fetchPodcasts(q: String, completion: @escaping (Result<Void, Error>) -> Void) {
        APIService.shared.fetchPodcastsInHomeItem2(q: q) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let homeItem2):
                    self?.homeItem2 = homeItem2
                    completion(.success(()))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    var numberOfHomeItem2: Int {
        return homeItem2.count
    }
    
    func homeItem2ImageUrl(at index: Int) -> String {
        return homeItem2[index].artworkUrl100
    }
    
    func homeItem2TrackName(at index: Int) -> String {
        return homeItem2[index].trackName
    }
    
    func homeItem2ReleaseDate(at index: Int) -> String {
        let dateFromRes = "\(homeItem2[index].releaseDate)"
        let date1 = dateFormatterEx.formatIso(input: dateFromRes)
        let formatting = dateFormatterEx.dateFormatter(format: "yyyy-MM-dd", input: date1)
        
        let result = formatting.stringDateFormatter(format: "MMMM, d - yyyy")
            
        return "\(result)"
    }
    
    func homeItem2(at index: Int) -> HomeItem2 {
        return homeItem2[index]
    }
    
}

extension HomeItem2ViewModel: ManagedObjectContextGetter { }
