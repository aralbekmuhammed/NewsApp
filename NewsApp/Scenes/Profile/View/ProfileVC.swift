//
//  ProfileVC.swift
//  NewsApp
//
//  Created by Muhammed Aralbek on 16.09.2024.
//

import UIKit
import SwiftUI
import Combine

class ProfileVC: UIHostingController<ProfileView> {
    
    private let viewModel = ProfileViewModel()
    
    private var subscriptions = Set<AnyCancellable>()
    
    required init() {
        super.init(rootView: ProfileView(viewModel: viewModel))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupCombine()
        viewModel.fetchBookmarks()
    }
    
    private func setupView(){
        rootView.onNewsTapped = { [unowned self] news in
            let controller = NewsDetailVC(news: news)
            present(controller, animated: true)
        }
        rootView.onPaywallTapped = { [unowned self] in
            let controller = PaywallVC()
            controller.modalTransitionStyle = .coverVertical
            controller.modalPresentationStyle = .overFullScreen
            present(controller, animated: true)
        }
    }
    
    private func setupCombine() {
        NewsManager.shared.bookmarksListener.sink { [weak viewModel] _ in
            viewModel?.fetchBookmarks()
        }.store(in: &subscriptions)
        
        viewModel.$errorMessage.sink { [unowned self] message in
            guard let message else { return }
            
            showAlert(withTitle: message, message: "Try again later")
        }.store(in: &subscriptions)
    }
    
    
}
