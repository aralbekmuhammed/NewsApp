//
//  NewsVC.swift
//  NewsApp
//
//  Created by Muhammed Aralbek on 16.09.2024.
//

import UIKit
import SwiftUI

class AuthorizationVC: UIHostingController<AuthorizationView> {
    
    private var viewModel: AuthorizationViewModel = .init()
    
    required init() {
        super.init(rootView: AuthorizationView(viewModel: viewModel))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.onAuthResult = { result in
            DispatchQueue.main.async { [unowned self] in
                switch result {
                case .success:
                    if !Store.shared.purchasedNonRenewableSubscriptions.isEmpty {
                        UIApplication.shared.rootViewController = TabBarController()
                    } else {
                        UIApplication.shared.rootViewController = PaywallVC()
                    }
                case .failure(let error):
                    showAlert(withTitle: error.localizedDescription, message: "Try again later")
                }
            }
        }
    }
    
}
