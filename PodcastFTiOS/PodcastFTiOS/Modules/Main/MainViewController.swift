//
//  ViewController.swift
//  PodcastFTiOS
//
//  Created by aldybuana on 13/11/22.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup() {
        tabBar.tintColor = UIColor(rgb: 0xCBFB5E)
        tabBar.unselectedItemTintColor = UIColor(rgb: 0x71737B)
    }

}

