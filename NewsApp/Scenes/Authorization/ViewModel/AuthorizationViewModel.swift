//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Muhammed Aralbek on 16.09.2024.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

class AuthorizationViewModel: ObservableObject {
    
    func signInWithGoogle() async throws {
        guard let rootViewController = await UIApplication.shared.rootViewController else { return }
        
        let authResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
        
        let user = authResult.user
        guard let idToken = user.idToken else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: user.accessToken.tokenString)
        try await Auth.auth().signIn(with: credential)
    }
    
}
