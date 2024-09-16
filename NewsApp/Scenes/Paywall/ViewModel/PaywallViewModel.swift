//
//  PaywallViewModel.swift
//  NewsApp
//
//  Created by Muhammed Aralbek on 16.09.2024.
//

import UIKit
import Combine
import StoreKit

class PaywallViewModel: ObservableObject {
    
    @discardableResult
    func subscribe() async throws -> Bool{
        if let sub = Store.shared.nonRenewables.first {
            let transaction = try await Store.shared.purchase(sub)
            return transaction != nil
        }
        return false
    }
    
    func restore(){
        Task {
            try? await AppStore.sync()
        }
    }
    
}
