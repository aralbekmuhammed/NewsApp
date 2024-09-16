//
//  AuthorizationView.swift
//  NewsApp
//
//  Created by Muhammed Aralbek on 12.09.2024.
//

import SwiftUI

struct AuthorizationView: View {
    
    @ObservedObject var viewModel: AuthorizationViewModel
    
    var onAuthResult: ClosureItem<Result<Void, Error>>?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            getBackgroundView()
            getBottomSheetView()
        }
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    private func getBackgroundView() -> some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                LinearGradient(colors: [Color.hex("2249D4"), Color.hex("E9EEFA")],
                               startPoint: .top, endPoint: .bottom)
                Image(.Common.authorizationBackground)
                    .resizable()
                    .scaledToFit()
                    .frame(height: geo.size.height / 1.5, alignment: .top)
            }
        }
    }
    
    @ViewBuilder
    private func getBottomSheetView() -> some View {
        VStack(spacing: 50) {
            VStack(spacing: 20) {
                Text("Get The Latest News And Updates")
                    .font(.Inter(32, .semibold))
                    .foregroundStyle(Color.Text.primary)
                Text("NewsApp brings you the world’s best journalism, all in one place. Trusted sources, curated by editors, and personalized for you.")
                    .font(.Inter(18, .regular))
                    .foregroundStyle(Color.Text.secondary)
            }
            Button {
                Task {
                    do {
                        try await viewModel.signInWithGoogle()
                        onAuthResult?(.success(()))
                    } catch {
                        onAuthResult?(.failure(error))
                    }
                }
            } label: {
                HStack(spacing: 8, content: {
                    Image(.Common.google)
                    Text("Sign in with Google")
                        .font(.Inter(16, .semibold))
                        .foregroundStyle(Color.hex("667080"))
                })
            }
            .frame(width: 248, height: 66)
            .background(Color.hex("EEF1F4"))
            .cornerRadius(10)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 52)
        .padding(.horizontal, 32)
        .background(Color.BG.primary)
        .clipShape(.rect(cornerRadii: .init(topLeading: 32, topTrailing: 32)))
    }
    
}

#Preview {
    AuthorizationView(viewModel: .init())
}
