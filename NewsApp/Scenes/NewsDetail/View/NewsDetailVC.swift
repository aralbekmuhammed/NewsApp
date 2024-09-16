//
//  NewsDetailVC.swift
//  NewsApp
//
//  Created by Muhammed Aralbek on 16.09.2024.
//

import UIKit
import SwiftUI

class NewsDetailVC: UIHostingController<NewsDetailView> {
    
    private let viewModel = NewsDetailViewModel()
    
    required init(news: NewsModel){
        super.init(rootView: NewsDetailView(viewModel: viewModel, news: news))
        
        modalTransitionStyle = .flipHorizontal
        modalPresentationStyle = .overFullScreen
        
        viewModel.checkIfNewsInBookmarks(news)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView(){
        rootView.onBackTapped = { [unowned self] in
            dismiss(animated: true)
        }
        rootView.onShareTapped = { [unowned self] news in
            guard let url = news.url else { return }
            
            present(UIActivityViewController(activityItems: [url], applicationActivities: nil), animated: true)
        }
        rootView.onError = { [unowned self] error in
            showAlert(withTitle: error.localizedDescription, message: "Try again later")
        }
    }
    
}
