//
//  XMLParserManager.swift
//  News-Feed
//
//  Created by  Arthur Bodrov on 29/05/2019.
//  Copyright © 2019  Arthur Bodrov. All rights reserved.
//

import Foundation

class XMLParserManager: NSObject, XMLParserDelegate {
    
    var parser = XMLParser()
    var feeds = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var newsTitle = NSMutableString()
    var link = NSMutableString()
    var img: [AnyObject] = []
    var newsDecription = NSMutableString()
    var authorOfNews = NSMutableString()
    
    func initWithURL(_ url: URL) -> AnyObject {
        startParse(url)
        return self
    }
    
    func startParse(_ url: URL) {
        feeds = []
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        parser.shouldProcessNamespaces = false
        parser.shouldReportNamespacePrefixes = false
        parser.shouldResolveExternalEntities = false
        parser.parse()
    }
    
    func allFeeds() -> NSMutableArray {
        return feeds
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element = elementName as NSString
        if (element as NSString).isEqual(to: "item") {
            elements =  NSMutableDictionary()
            elements = [:]
            newsTitle = NSMutableString()
            newsTitle = ""
            link = NSMutableString()
            link = ""
            newsDecription = NSMutableString()
            newsDecription = ""
            authorOfNews = NSMutableString()
            authorOfNews = ""
        } else if (element as NSString).isEqual(to: "enclosure") {
            if let urlString = attributeDict["url"] {
                img.append(urlString as AnyObject)
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if (elementName as NSString).isEqual(to: "item") {
            
            if newsTitle != "" {
                elements.setObject(newsTitle, forKey: "title" as NSCopying)
                
            }
            
            if link != "" {
                elements.setObject(link, forKey: "link" as NSCopying)
            }
            
            if newsDecription != "" {
                elements.setObject(newsDecription, forKey: "description" as NSCopying)
            }
            
            if authorOfNews != "" {
                elements.setObject(authorOfNews, forKey: "author" as NSCopying)
            }
            
            feeds.add(elements)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element.isEqual(to: "title") {
            newsTitle.append(string)
        } else if element.isEqual(to: "link") {
            link.append(string)
        } else if element.isEqual(to: "description") {
            newsDecription.append(string)
        } else if element.isEqual(to: "author") {
            authorOfNews.append(string)
        }
    }
    
}
