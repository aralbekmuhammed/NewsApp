//
//  UIViewController+.swift
//  NewsApp
//
//  Created by Muhammed Aralbek on 16.09.2024.
//

import UIKit

extension UIViewController {
    
    struct AlertAction{
        let text: String
        var type: UIAlertAction.Style = .default
        var action: Closure? = nil
    }
    
    func showAlert(withTitle: String?,
                   message: String?,
                   style: UIAlertController.Style = .alert,
                   actions: [AlertAction] = [AlertAction(text: "Ок")] ) {
        let alert = UIAlertController(title: withTitle, message: message, preferredStyle: style)
        actions.forEach { action in
            alert.addAction(.init(title: action.text, style: action.type, handler: { _ in
                action.action?()
            }))
        }
        present(alert, animated: true, completion: nil)
    }
    
    
}
