//
//  NewsManager.swift
//  NewsApp
//
//  Created by Muhammed Aralbek on 14.09.2024.
//

import Foundation
import Combine

class NewsManager {
    
    static let shared = NewsManager()
    
    var bookmarksListener: PassthroughSubject<Void, Never> = .init()
    
    private let key = "579f7e9e18284c96b9ef14f078dc95fb"
    
    private let fileManager = FileManager.default
    
    private lazy var documentsDirectory = fileManager.urls(for: .documentDirectory, in: .allDomainsMask)[0]
    
    private init() {
        
    }
    
    func fetchNews(topic: NewsTopic) async throws -> NewsResponse {
        let url = URL(string: "https://newsapi.org/v2/everything?q=\(topic.rawValue)&apiKey=\(key)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(NewsResponse.self, from: data)
        return response
    }
    
    func doesNewsExist(url: URL) -> Bool {
        let paths = (try? fileManager.contentsOfDirectory(atPath: documentsDirectory.path)) ?? []
        return paths.contains(encodeToFilename(from: url))
    }
    
    func fetchBookmarks() throws -> [NewsModel] {
        let paths = try fileManager.contentsOfDirectory(atPath: documentsDirectory.path)
        let datas = paths.compactMap { fileManager.contents(atPath: documentsDirectory.appendingPathComponent($0).path) }
        let decoder = JSONDecoder()
        let news = datas.compactMap { try? decoder.decode(NewsModel.self, from: $0) }
        return news
    }
    
    func addToBookmark(_ news: NewsModel) throws {
        guard let url = news.url else { return }
        
        let data = try JSONEncoder().encode(news)
        let path = documentsDirectory.appendingPathComponent(encodeToFilename(from: url))
        fileManager.createFile(atPath: path.path, contents: data)
        
        bookmarksListener.send(())
    }
    
    func deleteBookmark(_ news: NewsModel) throws {
        guard let url = news.url else { return }
        
        let paths = try fileManager.contentsOfDirectory(atPath: documentsDirectory.path)
        let filename = encodeToFilename(from: url)
        if paths.contains(filename) {
            let url = documentsDirectory.appendingPathComponent(filename)
            try fileManager.removeItem(at: url)
            
            bookmarksListener.send(())
        }
    }
    
    private func encodeToFilename(from url: URL) -> String {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_-")
        return url.absoluteString.addingPercentEncoding(withAllowedCharacters: allowedCharacters) ?? url.absoluteString
    }
    
    private func decodeFromFilename(filename: String) -> URL? {
        guard let string = filename.removingPercentEncoding,
              let url = URL(string: string) else { return nil }
        
        return url
    }
    
}
