//
//  PaywallVC.swift
//  NewsApp
//
//  Created by Muhammed Aralbek on 16.09.2024.
//

import UIKit
import SwiftUI
import Combine

class PaywallVC: UIHostingController<PaywallView> {
    
    private var viewModel = PaywallViewModel()
    
    private var subscriptions = Set<AnyCancellable>()
    
    required init() {
        super.init(rootView: PaywallView(viewModel: viewModel))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.onDismissTapped = { [unowned self] in
            dismissPaywall()
        }
        
        rootView.onError = { [weak self] error in
            self?.showAlert(withTitle: error.localizedDescription, message: "Try again later")
        }
        
        setupCombine()
    }
    
    private func dismissPaywall() {
        if presentingViewController != nil {
            dismiss(animated: true)
        } else {
            let controller = TabBarController()
            controller.modalTransitionStyle = .coverVertical
            controller.modalPresentationStyle = .overFullScreen
            present(controller, animated: true)
        }
    }
    
    private func setupCombine(){
        Store.shared.$purchasedNonRenewableSubscriptions
            .receive(on: DispatchQueue.main)
            .sink { [weak self] subs in
                guard let self, !subs.isEmpty else { return }
                
                dismissPaywall()
            }.store(in: &subscriptions)
    }
    
}
