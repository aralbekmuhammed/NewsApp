//
//  PaywallActions.swift
//  NewsApp
//
//  Created by Muhammed Aralbek on 16.09.2024.
//

import Foundation

enum PaywallActions: Int, CaseIterable, Identifiable {
    
    case restore, terms, privacy
    
    var id: Int {
        rawValue
    }
    
    var name: String {
        switch self {
        case .restore: "Restore purchase"
        case .terms: "Terms of Use"
        case .privacy: "Privacy Policy"
        }
    }
}
