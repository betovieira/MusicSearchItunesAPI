//
//  ViewController.swift
//  MusicSearchItunes
//
//  Created by Humberto Vieira de Castro on 12/22/15.
//  Copyright © 2015 Humberto Vieira de Castro. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageIndicator: UIPageControl!
    
    var numberOfItems = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageIndicator.numberOfPages = 0
        scrollView.delegate = self
        
        
    
    }
    @IBAction func searchForMusic(sender: AnyObject) {
        searchTextField.resignFirstResponder()
        
        if searchTextField.text != "" {
            
            ItunesConnection.getAlbumForString(searchTextField.text!) { (album:Album) -> () in
                
                self.numberOfItems++
                self.pageIndicator.numberOfPages = self.numberOfItems
                
                self.scrollView.contentSize = CGSizeMake(CGFloat(self.numberOfItems) * self.scrollView.frame.size.width, self.scrollView.frame.height)
                
                
                let musicView = NSBundle.mainBundle().loadNibNamed("MusicView", owner: self, options: nil).last as! MusicView
                
                
                musicView.frame = CGRectMake(CGFloat(self.numberOfItems - 1) * self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)
                musicView.updateConstraints()
                
                
    
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    musicView.addDataToMusicView(album)
                    self.scrollView.addSubview(musicView)
                    self.scrollView.scrollRectToVisible(musicView.frame, animated: true)
                    
                })
                
                print(album.title)
            }
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageIndicator.currentPage = page
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

