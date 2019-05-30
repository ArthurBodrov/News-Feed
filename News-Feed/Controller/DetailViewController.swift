//
//  DetailViewController.swift
//  News-Feed
//
//  Created by  Arthur Bodrov on 29/05/2019.
//  Copyright © 2019  Arthur Bodrov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var bigImage: UIImageView!
    
    @IBOutlet weak var bigTitle: UILabel!
    
    @IBOutlet weak var detailDescription: UILabel!

    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var gap: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        decorationOfImage()
        
    }
    
    var titleOfNews: String = ""
    var imageData: UIImage?
    var descriptionOfNews: String = ""
    var link: String = ""
    var authorOfNews: String = ""
    
    func loadData(){
        bigTitle.text = titleOfNews
        bigImage.image = imageData
        detailDescription.text = descriptionOfNews
        authorLabel.text = authorOfNews
        
    }
    
    func decorationOfImage() {
        bigImage.layer.cornerRadius = 10
        bigImage.layer.masksToBounds = true
    }

}
