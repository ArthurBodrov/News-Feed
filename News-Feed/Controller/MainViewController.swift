//
//  ViewController.swift
//  News-Feed
//
//  Created by  Arthur Bodrov on 29/05/2019.
//  Copyright © 2019  Arthur Bodrov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, XMLParserDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var myFeed : NSArray = []
    var feedImgs: [AnyObject] = []
    var url1: URL!
    var url2: URL!
    
    private let lentaURL: URL = URL(string: "https://lenta.ru/rss")!
    private let gazetaURL: String =  "https://www.gazeta.ru/export/rss/lenta.xml"
    
//    var urls: [URL] = [lentaURL, gazetaURL]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
//        url1 = URL(string: lentaURL)!
//        loadRss(url1)
        
        url2 = URL(string: gazetaURL)!
        loadRss(url2)
    }
    
    func loadRss(_ data: URL) {
        
        // XmlParserManager instance/object/variable.
        let myParser : XMLParserManager = XMLParserManager().initWithURL(data) as! XMLParserManager
        
        feedImgs = myParser.img as [AnyObject]
        myFeed = myParser.feeds
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.collectionView.reloadData()
        })
        
        
    }
    
}

