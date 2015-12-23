//
//  ItunesConnection.swift
//  MusicSearchItunes
//
//  Created by Humberto Vieira de Castro on 12/22/15.
//  Copyright © 2015 Humberto Vieira de Castro. All rights reserved.
//

import UIKit

class ItunesConnection: NSObject {

    /* Cria uma função de classe para fazer o request no itunes */
    class func getAlbumForString(searchString: String, completionHandler: (Album) -> ()) {
        
        /* Cria um parametro preparado para o método GET */
        let escapedString = searchString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
        
        let url = NSURL(string: "https://itunes.apple.com/search?term=\(escapedString!)&media=music")
        
        /* Faz o request na url */
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            if error == nil {
                
                do {
                    /* Faz a serialização do JSON e coloca no objeto */
                    let itunesDict = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                    let resultsArray = itunesDict.objectForKey("results") as! [ Dictionary <String, AnyObject> ]
                    
                    /* Se tiver algum resultado na busca ele retorna o primeiro resultado */
                    if resultsArray.count > 0 {
                        if let resultDict = resultsArray.first {
                            let artist = resultDict["artistName"] as! String
                            let artworkURL = resultDict["artworkUrl100"] as! String
                            let albumTitle = resultDict["collectionName"] as! String
                            let genre = resultDict["primaryGenreName"] as! String
                            
                            let album = Album(title: albumTitle, artist: artist, genre: genre, artworkURL: artworkURL)
                            
                            /* Chama o clojure/callback do parametro */
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
