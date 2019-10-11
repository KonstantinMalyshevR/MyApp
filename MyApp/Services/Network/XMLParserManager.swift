//
//  XMLParserManager.swift
//  MyApp
//
//  Created by Konstantin Malyshev on 10/10/2019.
//  Copyright © 2019 Konstantin Malyshev. All rights reserved.
//

import Foundation

class XMLParserManager:  NSObject, XMLParserDelegate {
    private var parser = XMLParser()
    private var news = [NewsObject]()
    private var newsObject = NewsObject()
    private var element = NSString()
    private var ftitle = ""
    private var fdescription = ""

    func initWithURL(_ url :URL) -> AnyObject {
        startParse(url)
        return self
    }

    private func startParse(_ url: URL) {
        news = []
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        parser.shouldProcessNamespaces = false
        parser.shouldReportNamespacePrefixes = false
        parser.shouldResolveExternalEntities = false
        parser.parse()
    }

    func getNews() -> [NewsObject] {
        return news
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element = elementName as NSString
        if (element as NSString).isEqual(to: "item") {
            newsObject =  NewsObject()
            ftitle = ""
            fdescription = ""
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName as NSString).isEqual(to: "item") {
            if ftitle != "" {
                newsObject.title = ftitle
            }
            if fdescription != "" {
                newsObject.detail = fdescription
            }
            news.append(newsObject)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element.isEqual(to: "title") {
            ftitle.append(string)
        } else if element.isEqual(to: "description") {
            fdescription.append(string)
        }
    }
}
