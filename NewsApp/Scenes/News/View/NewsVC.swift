//
//  NewsVC.swift
//  NewsApp
//
//  Created by Muhammed Aralbek on 16.09.2024.
//

import UIKit
import SwiftUI
import Combine

class NewsVC: UIHostingController<NewsView> {
    
    var viewModel: NewsVM = .init()
    
    private var subscriptions = Set<AnyCancellable>()
    
    required init() {
        super.init(rootView: NewsView(viewModel: viewModel))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupCombine()
        viewModel.fetchNews()
    }
    
    private func setupView(){
        rootView.onNewsTapped = { [unowned self] news in
            let controller = NewsDetailVC(news: news)
            present(controller, animated: true)
        }
    }
    
    private func setupCombine() {
        viewModel.$errorMessage.sink { [weak self] errorMessage in
            if let self, let errorMessage {
                showAlert(withTitle: errorMessage, message: "Try again later")
            }
        }.store(in: &subscriptions)
    }
    
}
