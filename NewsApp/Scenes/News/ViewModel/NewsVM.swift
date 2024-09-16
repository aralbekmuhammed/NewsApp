//
//  NewsVM.swift
//  NewsApp
//
//  Created by Muhammed Aralbek on 16.09.2024.
//

import Foundation

final class NewsVM: ObservableObject {
    
    @Published var selectedTopic: NewsTopic = .travel {
        didSet {
            guard selectedTopic != oldValue else { return }
            
            fetchNews()
        }
    }
    
    @Published var news: [NewsModel] = []
    
    @Published var errorMessage: String? = nil
    
    func fetchNews() {
        news = []
        errorMessage = nil
        
        Task {
            do {
                let response = try await NewsManager.shared.fetchNews(topic: selectedTopic)
                DispatchQueue.main.async {
                    switch response.status {
                    case .ok:
                        self.news = response.articles ?? []
                    case .error:
                        self.errorMessage = response.message
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
