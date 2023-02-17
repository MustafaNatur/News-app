//
//  Constants.swift
//  NewsAppTFS
//
//  Created by Мустафа Натур on 04.02.2023.
//

import Foundation

struct Constants {
    static var page = Int.random(in: 1..<10)
    static var url:String {
        return "https://newsapi.org/v2/everything?q=apple&pagesize=10&page=\(page)&from=2023-02-04&to=2023-02-04&sortBy=popularity&apiKey=10c3c51b98354560b7a1dd881cf94255"
    }
    
    static let searchStringUrl = "https://newsapi.org/v2/everything?from=2023-02-04&to=2023-02-04&sortBy=popularity&apiKey=10c3c51b98354560b7a1dd881cf94255&q="
    static func changePage() {
        page+=1
        guard page <= 10 else {
            page = 1
            return
        }
    }
    static let defaultLink = "https://stadt-bremerhaven.de/wp-content/uploads/2023/02/Low-Denon-AVC-A1H-Black-In-situ-4-1.jpg"
}
