//
//  APICaller.swift
//  NewsAppTFS
//
//  Created by Мустафа Натур on 04.02.2023.
//

import Foundation


final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    public func getTopStories(completion: @escaping (Result<[Article], Error>) -> Void) {
        Constants.changePage()
        guard let url = URL(string:Constants.url) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    

    
    public func searchStories(with q:String, completion: @escaping (Result<[Article], Error>) -> Void) {
        guard !q.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        let url = Constants.searchStringUrl + q
        guard let url = URL(string:url) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    
}
