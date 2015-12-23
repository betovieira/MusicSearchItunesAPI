//
//  Album.swift
//  MusicSearchItunes
//
//  Created by Humberto Vieira de Castro on 12/22/15.
//  Copyright © 2015 Humberto Vieira de Castro. All rights reserved.
//

import UIKit

class Album: NSObject {
    var title: String!
    var artist: String!
    var genre: String!
    var artworkURL: String!
    
    init(title: String, artist: String, genre: String, artworkURL: String) {
        
        super.init()
        
        self.title = title
        self.artist = artist
        self.genre = genre
        self.artworkURL = artworkURL
        
    }
    
}
