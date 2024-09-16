//
//  SceneDelegate.swift
//  NewsApp
//
//  Created by Muhammed Aralbek on 16.09.2024.
//

import UIKit
import SwiftUI
import GoogleSignIn

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        window = .init(windowScene: windowScene)
        
        window?.rootViewController = UIStoryboard(name: "Launch Screen", bundle: nil).instantiateInitialViewController()
        window?.makeKeyAndVisible()
        
        GIDSignIn.sharedInstance.restorePreviousSignIn { [self] user, error in
            if error != nil || user == nil {
                window?.rootViewController = AuthorizationVC()
            } else {
                Task {
                    await Store.shared.requestProducts()
                    
                    if !Store.shared.purchasedNonRenewableSubscriptions.isEmpty {
                        window?.rootViewController = TabBarController()
                    } else {
                        window?.rootViewController = PaywallVC()
                    }
                }
            }
        }
        
    }
    
}
