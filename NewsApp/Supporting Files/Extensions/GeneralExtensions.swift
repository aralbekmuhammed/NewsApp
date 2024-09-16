//
//  GeneralExtensions.swift
//  NewsApp
//
//  Created by Muhammed Aralbek on 13.09.2024.
//

import UIKit

typealias Closure = () -> ()
typealias ClosureItem<T: Any> = (T) -> ()

extension UIApplication {
    
    var rootViewController: UIViewController? {
        get {
            window?.rootViewController
        } set {
            window?.rootViewController = newValue
        }
    }
    
    private var window: UIWindow? {
        (connectedScenes.first as? UIWindowScene)?.windows.first
    }
    
}

extension Date {
    
    func formatted(dateFormat: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: self)
    }
    
}
