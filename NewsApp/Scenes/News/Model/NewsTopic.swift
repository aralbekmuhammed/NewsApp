//
//  NewsTopic.swift
//  NewsApp
//
//  Created by Muhammed Aralbek on 16.09.2024.
//

import Foundation

enum NewsTopic: String, CaseIterable, Identifiable {
    
    var id: String { rawValue }
    
    case travel, technology, business
    
    var name: String {
        switch self {
        case .travel: "Travel"
        case .technology: "Technology"
        case .business: "Business"
        }
    }
}
