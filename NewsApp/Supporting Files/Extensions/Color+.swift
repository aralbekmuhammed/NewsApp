//
//  Color+.swift
//  NewsApp
//
//  Created by Muhammed Aralbek on 12.09.2024.
//

import SwiftUI

extension Color {
    
    static func hex(_ hex: String) -> Color {
        var rgb: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgb)
        
        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0
        
        return Color(red: red, green: green, blue: blue)
    }
    
}
