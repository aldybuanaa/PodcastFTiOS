//
//  HomeViewController.swift
//  PodcastFTiOS
//
//  Created by aldybuana on 13/11/22.
//

import UIKit
import Foundation

class HomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    weak var recommendedListView: UICollectionView?
    
    let viewModelHomeItem1 = HomeItem1ViewModel()
    let viewModelHomeItem2 = HomeItem2ViewModel()
    
    var homeItem1Count: Int = 0
    var homeItem2Count: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadHomeItem1(q: "makna")
        loadHomeItem2(q: "reality club")
    }
    
    func setup() {
        collectionView.dataSource = self
        collectionView.delegate = self
        self.collectionView.reloadData()
    }

}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == self.collectionView {
            return 2
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            if section == 0 {
                return 1
            } else {
                return self.homeItem2Count
            }
        } else {
            return self.homeItem1Count
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView != self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item1", for: indexPath) as! HomeItem1ViewCell
            
            let index = indexPath.row
            cell.coverImage.kf.setImage(with: URL(string: viewModelHomeItem1.homeItem1ImageUrl(at: index))) { (result) in
                switch result {
                case.success:
                    cell.coverImage.contentMode = .scaleAspectFill
                case .failure:
                    cell.coverImage.contentMode = .center
                    cell.coverImage.image = UIImage(systemName: "photo")
                }
            }
            
            return cell
            
        } else {
            if indexPath.section == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemList", for: indexPath) as! HomeItemListViewCell
                
                self.recommendedListView = cell.collectionView

                cell.collectionView.dataSource = self
                cell.collectionView.delegate = self
                
                return cell
                
            } else {
                let cells = collectionView.dequeueReusableCell(withReuseIdentifier: "item2", for: indexPath) as! HomeItem2ViewCell
                
                let item = indexPath.item
                let dateLabels = viewModelHomeItem2.homeItem2ReleaseDate(at: item)
                
                cells.titleName.text = viewModelHomeItem2.homeItem2TrackName(at: item)
                cells.releaseDate.text = "Release date: \(dateLabels)"
                cells.thumbImage.kf.setImage(with: URL(string: viewModelHomeItem2.homeItem2ImageUrl(at: item))) { (result) in
                    switch result {
                    case .success:
                        cells.thumbImage.contentMode = .scaleAspectFill
                    case .failure:
                        cells.thumbImage.contentMode = .center
                        cells.thumbImage.image = UIImage(systemName: "photo")
                    }
                }
                
                return cells
                
            }
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
        
        let titleLabel = view.viewWithTag(100) as! UILabel
        let subtitleLabel = view.viewWithTag(101) as! UILabel
        
        if indexPath.section == 0 {
            titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
            titleLabel.text = "FazzTrack Weekly"
            titleLabel.isHidden = false
            subtitleLabel.text = "FazzTrack Podcast Collection"
            subtitleLabel.isHidden = false
        } else {
            titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
            titleLabel.isHidden = false
            titleLabel.text = "Collection"
            subtitleLabel.isHidden = true
            
            
        }
        
        return view
    }
}


// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func loadHomeItem1(q: String) {
        viewModelHomeItem1.fetchPodcasts(q: q) { [weak self] (_) in
            guard let `self` = self else { return }
            self.homeItem1Count = self.viewModelHomeItem1.numberOfHomeItem1
        }
    }
    
    func loadHomeItem2(q: String) {
        viewModelHomeItem2.fetchPodcasts(q: q) { [weak self] (_) in
            guard let `self` = self else { return }
            self.homeItem2Count = self.viewModelHomeItem2.numberOfHomeItem2
            self.setup()
        }
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == self.collectionView {
        if section == 0 {
            return UIEdgeInsets(top: 0, left: 0, bottom: -10, right: 0)
        } else {
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }

        } else {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0 {
            return 10
        }
        else {
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if collectionView == self.recommendedListView {
            return CGSize(width: 300, height: 200)
        } else {
            if indexPath.section != 0 {
                let screenwidth = UIScreen.main.bounds.width
                let width = screenwidth
                let height = 90.0
                return CGSize(width: width, height: height)
            } else {
                let screenWidth = UIScreen.main.bounds.width
                return CGSize(width: screenWidth, height: 200)
            }
        }
        
    }
    
}
