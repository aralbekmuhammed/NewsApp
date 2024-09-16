//
//  NewsModel.swift
//  NewsApp
//
//  Created by Muhammed Aralbek on 16.09.2024.
//

import Foundation
import UIKit

struct NewsResponse: Decodable {
    enum Status: String, Decodable {
        case ok, error
    }
    let status: Status
    let articles: [NewsModel]?
    let message: String?
}

struct NewsModel: Codable, Identifiable, Equatable {
    
    enum CodingKeys: String, CodingKey {
        case title, description, urlToImage, author, publishedAt, url
    }
    
    var id: String = UUID().uuidString
    var title: String?
    var url: URL?
    var description: String?
    var urlToImage: URL?
    var author: String?
    var localPath: URL?
    
    private var publishedAt: String?
    
    var dateCreated: Date? {
        guard let publishedAt else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        return dateFormatter.date(from: publishedAt)
    }
    
    
    init(title: String? = nil, url: URL? = nil, description: String? = nil, urlToImage: URL? = nil, author: String? = nil, publishedAt: String? = nil) {
        self.title = title
        self.url = url
        self.description = description
        self.urlToImage = urlToImage
        self.author = author
        self.publishedAt = publishedAt
    }
    
}
