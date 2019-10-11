//
// Created by Konstantin Malyshev on 11/10/2019.
// Copyright (c) 2019 Konstantin Malyshev. All rights reserved.
//

import Foundation

class DataService {

    private let url = URL(string: "https://lenta.ru/rss/news")!

    func getData() -> [NewsObject] {
        let myParser: XMLParserManager = XMLParserManager().initWithURL(url) as! XMLParserManager
        var newsArray = myParser.getNews()
        if newsArray.count > 0 {
            SharedPreferencesService.saveNews(entity: newsArray)
        } else {
            if let savedNews = SharedPreferencesService.loadNews() {
                newsArray = savedNews
            }
        }
        return newsArray
    }
}