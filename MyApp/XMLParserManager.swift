//
//  XMLParserManager.swift
//  MyApp
//
//  Created by Konstantin Malyshev on 10/10/2019.
//  Copyright © 2019 Konstantin Malyshev. All rights reserved.
//

import Foundation

struct NewsObject {
    var title = ""
    var detail = ""
}

class XMLParserManager:  NSObject, XMLParserDelegate {
    private var parser = XMLParser()
    private var news = [NewsObject]()
    private var newsObject = NewsObject()
    var controllerDelegate: MainViewControllerProtocol?

    private var element = NSString()
    private var ftitle = ""
    private var fdescription = ""

    func startRequest(_ url :URL){
        let session = URLSession.shared
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy)
        request.httpMethod = "GET"
        session.dataTask(with: request)
        let task = session.dataTask(with: url) { data, response, error in
            do {
                if let data = data {
                    self.startParse(data)
                }
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }

    private func startParse(_ data: Data) {
        news = []
        parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
    }
    
    func getNews() -> [NewsObject] {
        return news
    }

    func parserDidEndDocument(_ parser: XMLParser) {
        controllerDelegate?.refreshTable()
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
