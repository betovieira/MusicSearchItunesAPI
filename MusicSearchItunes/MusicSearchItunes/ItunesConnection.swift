//
//  ItunesConnection.swift
//  MusicSearchItunes
//
//  Created by Humberto Vieira de Castro on 12/22/15.
//  Copyright © 2015 Humberto Vieira de Castro. All rights reserved.
//

import UIKit

class ItunesConnection: NSObject {

    class func getAlbumForString(searchString: String, completionHandler: (Album) -> ()) {
        
        
        let escapedString = searchString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
        
        let url = NSURL(string: "https://itunes.apple.com/search?term=\(escapedString!)&media=music")
        
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            if error == nil {
                do {
                    
                    let itunesDict = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                    let resultsArray = itunesDict.objectForKey("results") as! [ Dictionary <String, AnyObject> ]
                    
                    if resultsArray.count > 0 {
                        if let resultDict = resultsArray.first {
                            let artist = resultDict["artistName"] as! String
                            let artworkURL = resultDict["artworkUrl100"] as! String
                            let albumTitle = resultDict["collectionName"] as! String
                            let genre = resultDict["primaryGenreName"] as! String
                            
                            let album = Album(title: albumTitle, artist: artist, genre: genre, artworkURL: artworkURL)
                            
                            completionHandler(album)
                            
                        }
                    }
                 
                } catch {
                    print("ERRO - REQUEST")
                }
            }
            
        })
        
        task.resume()
        
    }
    
}
