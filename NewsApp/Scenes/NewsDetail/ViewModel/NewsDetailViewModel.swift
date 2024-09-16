//
//  NewsDetailViewModel.swift
//  NewsApp
//
//  Created by Muhammed Aralbek on 16.09.2024.
//

import UIKit

class NewsDetailViewModel: ObservableObject {
    
    @Published var isInBookmark = false
    
    func checkIfNewsInBookmarks(_ news: NewsModel){
        if let url = news.url {
            isInBookmark = NewsManager.shared.doesNewsExist(url: url)
        }
    }
    
    func bookmarkDidTap(_ news: NewsModel) throws {
        if isInBookmark {
            try NewsManager.shared.deleteBookmark(news)
        } else {
            try NewsManager.shared.addToBookmark(news)
        }
        
        isInBookmark.toggle()
    }
    
}
