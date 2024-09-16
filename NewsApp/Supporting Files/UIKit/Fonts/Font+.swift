//
//  Font+.swift
//  NewsApp
//
//  Created by Muhammed Aralbek on 12.09.2024.
//

import SwiftUI
import UIKit.UIFont

extension Font {
    
    enum InterWeight {
        case bold, light, medium, regular, semibold
    }
    
    static func Inter(_ size: CGFloat, _ weight: InterWeight) -> Font {
        switch weight {
        case .bold: Font.custom("Inter18pt-Bold", size: size)
        case .light: Font.custom("Inter18pt-Light", size: size)
        case .medium: Font.custom("Inter18pt-Medium", size: size)
        case .regular: Font.custom("Inter18pt-Regular", size: size)
        case .semibold: Font.custom("Inter18pt-SemiBold", size: size)
        }
    }

}
