//
//  ProfileView.swift
//  NewsApp
//
//  Created by Muhammed Aralbek on 16.09.2024.
//

import SwiftUI
import Kingfisher
import GoogleSignIn

struct ProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
    @ObservedObject var store: Store = .shared
    
    var onNewsTapped: ClosureItem<NewsModel>?
    
    var onPaywallTapped: Closure?
    
    var body: some View {
        VStack(spacing: 0) {
            Group {
                getHeaderView()
                getPremiumView()
            }
            .padding(.horizontal, 32)
            getBookmarksView(news: viewModel.bookmarks)
        }
    }
    
    @ViewBuilder
    private func getHeaderView() -> some View {
        HStack(spacing: 24) {
            let url = GIDSignIn.sharedInstance.currentUser?.profile?.imageURL(withDimension: 720)
            KFImage(url)
                .resizable()
                .fade(duration: 0.25)
                .placeholder({ _ in
                    Color.gray.opacity(0.4)
                })
                .frame(width: 120, height: 120)
                .clipShape(Circle())
            
            let name = GIDSignIn.sharedInstance.currentUser?.profile?.name ?? ""
            Text(name)
                .font(.Inter(24, .semibold))
                .foregroundColor(.Text.primary)
                .lineLimit(2)
            
            Spacer(minLength: 0)
        }
        .padding(.vertical, 24)
    }
    
    @ViewBuilder
    private func getPremiumView() -> some View {
        let hasSub = !store.purchasedNonRenewableSubscriptions.isEmpty
        VStack(spacing: 16) {
            Divider()
            HStack {
                Text("Premium")
                    .font(.Inter(24, .bold))
                    .foregroundColor(.Text.primary)
                Spacer(minLength: 0)
                Button {
                    if !hasSub {
                        onPaywallTapped?()
                    }
                } label: {
                    Text(hasSub ? "Enabled" : "Subscribe")
                        .font(.Inter(14, .semibold))
                        .foregroundColor(.Text.primary)
                        .frame(width: 116, height: 40)
                        .background(Color.hex("D9D9D9"))
                        .cornerRadius(10)
                }
            }
            Divider()
        }
    }
    
    @ViewBuilder
    private func getBookmarksView(news: [NewsModel]) -> some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 16) {
                Text("Bookmarks")
                    .font(.Inter(24, .bold))
                    .foregroundColor(.Text.primary)
                ForEach(news) { newsItem in
                    NewsCellView(news: newsItem)
                        .onTapGesture {
                            onNewsTapped?(newsItem)
                        }
                }
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 32)
        }
    }
}

#Preview {
    ProfileView(viewModel: .init())
}
