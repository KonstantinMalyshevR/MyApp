//
// Created by Konstantin Malyshev on 11/10/2019.
// Copyright (c) 2019 Konstantin Malyshev. All rights reserved.
//

import Foundation

final class SharedPreferencesService {
    static let newsKey = "news"

    static func saveNews(entity: [NewsObject]){
        let data = try? JSONEncoder().encode(entity)
        UserDefaults.standard.set(data, forKey: newsKey)
    }

    static func loadNews() -> [NewsObject]? {
        if let data = UserDefaults.standard.data(forKey: newsKey) {
            do {
                return try? JSONDecoder().decode([NewsObject].self, from: data)
            } catch {
                return nil
            }
        }
        return nil
    }
}