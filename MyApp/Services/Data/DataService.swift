//
// Created by Konstantin Malyshev on 11/10/2019.
// Copyright (c) 2019 Konstantin Malyshev. All rights reserved.
//

import Foundation

class DataService {

    private let url = URL(string: "https://lenta.ru/rss/news")!
    private var data: [NewsObject] = []

    func start() {
        let myParser: XMLParserManager = XMLParserManager().initWithURL(url) as! XMLParserManager
        var newsArray = myParser.getNews()
        if newsArray.count > 0 {
            SharedPreferencesService.saveNews(entity: newsArray)
        } else {
            if let savedNews = SharedPreferencesService.loadNews() {
                newsArray = savedNews
            }
        }
        data = newsArray
    }

    func getData(page: Int, limit: Int) -> [NewsObject] {
        let offset = page * limit
        if offset + limit > data.count {
            return []
        }
        let subarray: [NewsObject] = Array(data[offset ..< offset + limit])
        return subarray
    }
}