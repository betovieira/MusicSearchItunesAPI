//
//  MusicView.swift
//  MusicSearchItunes
//
//  Created by Humberto Vieira de Castro on 12/22/15.
//  Copyright © 2015 Humberto Vieira de Castro. All rights reserved.
//

import UIKit

class MusicView: UIView {

    @IBOutlet var artworkImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    
    func addDataToMusicView(album: Album) {
        
        artworkImageView.image = UIImage(data: NSData(contentsOfURL: NSURL(string: album.artworkURL!)!)!)
        titleLabel.text = album.title
        artistLabel.text = album.artist
        genreLabel.text = album.genre
        
        
        
        
        
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    
    
    

}
