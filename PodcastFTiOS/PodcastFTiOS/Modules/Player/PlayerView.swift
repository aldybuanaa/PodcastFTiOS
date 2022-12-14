//
//  PlayerView.swift
//  PodcastFTiOS
//
//  Created by aldybuana on 24/11/22.
//

import UIKit

protocol PlayerViewDelegate: NSObjectProtocol {
    func playerViewPlayButtonTapped(_ view: PlayerView)
    func playerViewRewindButtonTapped(_ view: PlayerView)
    func playerViewForwardButtonTapped(_ view: PlayerView)
    func playerViewTapped(_ view: PlayerView)
}

class PlayerView: UIView {
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backwardButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    weak var delegate: PlayerViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        Bundle.main.loadNibNamed("PlayerView", owner: self)
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @IBAction func backwardButtonTapped(_ sender: Any) {
        delegate?.playerViewRewindButtonTapped(self)
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
        delegate?.playerViewPlayButtonTapped(self)
    }
    
    @IBAction func forwardButtonTapped(_ sender: Any) {
        delegate?.playerViewForwardButtonTapped(self)
    }
    
    @IBAction func viewTapped(_ sender: Any) {
        delegate?.playerViewTapped(self)
    }
    
    
}
