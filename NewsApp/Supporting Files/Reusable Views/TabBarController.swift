//
//  TabBarController.swift
//  NewsApp
//
//  Created by Muhammed Aralbek on 16.09.2024.
//

import UIKit

class TabBarController: UITabBarController {
    
    private lazy var newsVC: NewsVC = {
        let view = NewsVC()
        return view
    }()
    
    private lazy var profileVC: ProfileVC = {
        let view = ProfileVC()
        return view
    }()
    
    override func loadView() {
        super.loadView()
        
        setupTabBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tabBar.frame.size.height = 72
        tabBar.frame.origin.y = view.frame.height - 72
        
        tabBar.layer.cornerRadius = 24
        tabBar.layer.masksToBounds = true
        tabBar.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    private func setupViewControllers(){
        setViewControllers([
            newsVC, profileVC
        ], animated: false)
        
        newsVC.tabBarItem.image = .tabGlobe
        profileVC.tabBarItem.image = .tabPerson
    }
    
    private func setupTabBar(){
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = .systemPink.withAlphaComponent(0.08)
        
        tabBar.scrollEdgeAppearance = tabBarAppearance
        tabBar.standardAppearance = tabBarAppearance
        
        tabBar.tintColor = .black
    }
    
}
