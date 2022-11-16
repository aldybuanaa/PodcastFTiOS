//
//  HomeViewController.swift
//  PodcastFTiOS
//
//  Created by aldybuana on 13/11/22.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    weak var recommendedListView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }

}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    // amount of section
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == self.collectionView {
            return 2
        } else {
            return 1
        }
    }
    
    // amount of item in section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            if section == 0 {
                return 1
            } else {
                return 10
            }
        } else {
            return 6
            
        }
        
    }
    
    
    // to show the item at section
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView != self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item1", for: indexPath) as! HomeItem1ViewCell
            
//            let mood = moods[indexPath.row]
            
            cell.coverImage.image = UIImage(named: "cover1")
            
            
            
            return cell
            
        } else {
            
            // section 1 recommendedList
            if indexPath.section == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemList", for: indexPath) as! HomeItemListViewCell
                
                cell.backgroundColor = .clear
                
                self.recommendedListView = cell.collectionView
                
                // collectionView to provide data
                cell.collectionView.dataSource = self
                cell.collectionView.delegate = self
                
                return cell
                
                // section 2 HomeItemViewCell
            } else {
                let cells = collectionView.dequeueReusableCell(withReuseIdentifier: "item2", for: indexPath) as! HomeItem2ViewCell
                
                let item = indexPath.item
                
                cells.titleName.text = item == 0 ? "Is it the Answer" : "Never Get Better"
                cells.releaseDate.text = item == 0 ? "Release date:  March, 23 - 2017" : "Release date: March, 23 - 2017"
                cells.thumbImage.image = item == 0 ? UIImage(named: "thumb1") : UIImage(named: "thumb1")
                
//                cells.delegate = self
                
                return cells
                
            }
            
        }
        
    }
    
    // func for header
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
    
    
    // to hide second header
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
//        if collectionView == self.recommendedListView {
//            return .zero
//        } else {
//            if section == 0 {
//                return CGSize(width: 50, height: 100)
//            } else {
//                return .zero
//            }
//        }
//
//    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {

    // size inset for each section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == self.collectionView {
        if section == 0 {
            return UIEdgeInsets(top: 0, left: -10, bottom: 0, right: -10)
        } else {
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }

        } else {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        }
    }
    // space size for each item in section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    // minimum space for each item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    // size of item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if collectionView == self.recommendedListView {
            return CGSize(width: 65, height: 99)
        } else {
            
        // section 2
        if indexPath.section != 0 {
            let screenwidth = UIScreen.main.bounds.width
            return CGSize(width: screenwidth, height: 72)
        } else {
            
            // section 1
            let leftInset: CGFloat = 0.0
            let rightInset: CGFloat = 0.0
            
            let screenwidth = UIScreen.main.bounds.width
            let width = screenwidth - (leftInset + rightInset)
            let height = 200.0
            return CGSize(width: width, height: height)
        }
        }
        
    }
    
}
