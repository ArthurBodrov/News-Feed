//
//  ExtensionMainVC.swift
//  News-Feed
//
//  Created by  Arthur Bodrov on 29/05/2019.
//  Copyright © 2019  Arthur Bodrov. All rights reserved.
//

import UIKit

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myFeed.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as! NewsCell
        
        let url = NSURL(string:feedImgs[indexPath.row] as! String)
        let data = NSData(contentsOf:url! as URL)

        if data != nil {
            
            var image = UIImage(data:data! as Data)
            image = resizeImage(image: image!, toTheSize: CGSize(width: 390, height: 250))
            
            cell.newsImage?.image = image
        }
        
        
       
        
        cell.newsTitle?.text = (myFeed.object(at: indexPath.row) as AnyObject).object(forKey: "title") as? String
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailNewsSegue", sender: self)
    }
    
    func resizeImage(image:UIImage, toTheSize size:CGSize) -> UIImage {
        
        let scale = CGFloat(max(size.width/image.size.width,
                                size.height/image.size.height))
        let width:CGFloat  = image.size.width * scale
        let height:CGFloat = image.size.height * scale;
        
        let rr:CGRect = CGRect(x: 0, y: 0, width: width, height: height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        image.draw(in: rr)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return newImage!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailNewsSegue" {
            if let detailVC = segue.destination as? DetailViewController {
                let indexPaths = self.collectionView.indexPathsForSelectedItems
                let indexPath = indexPaths![0] as! NSIndexPath
                
                let titleOfNews = ((myFeed.object(at: indexPath.row) as AnyObject).object(forKey: "title") as? String)!
                
                detailVC.titleOfNews = titleOfNews
                
                let url = NSURL(string:feedImgs[indexPath.row] as! String)
                let data = NSData(contentsOf:url! as URL)
                
                if data != nil {
                    var image = UIImage(data:data! as Data)
                    detailVC.imageData = image
                }
                
                let descriptionOfNews = ((myFeed.object(at: indexPath.row) as AnyObject).object(forKey: "description") as? String)!
                detailVC.descriptionOfNews = descriptionOfNews
                
                let authoOfNews = ((myFeed.object(at: indexPath.row) as AnyObject).object(forKey: "author") as? String)!
                detailVC.authorOfNews = authoOfNews
            }
        }
    }
    
}
