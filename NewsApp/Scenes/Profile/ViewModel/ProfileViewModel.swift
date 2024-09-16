//
//  ProfileViewModel.swift
//  NewsApp
//
//  Created by Muhammed Aralbek on 16.09.2024.
//

import UIKit

class ProfileViewModel: ObservableObject {
    
    @Published var bookmarks: [NewsModel] = []
    
    @Published var errorMessage: String?
    
    func fetchBookmarks() {
        do {
            bookmarks = try NewsManager.shared.fetchBookmarks()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
}
