//
//  NewsDetailView.swift
//  NewsApp
//
//  Created by Muhammed Aralbek on 16.09.2024.
//

import SwiftUI

struct NewsDetailView: View {
    
    @ObservedObject var viewModel: NewsDetailViewModel
    
    let news: NewsModel
    
    var onBackTapped: Closure?
    
    var onShareTapped: ClosureItem<NewsModel>?
    
    var onError: ClosureItem<Error>?
    
    var body: some View {
        if let url = news.url {
            ZStack(alignment: .bottom) {
                WebView(url: url)
                    .ignoresSafeArea(edges: .bottom)
                getBottomView()
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
    
    @ViewBuilder
    private func getBottomView() -> some View{
        HStack {
            Button {
                onBackTapped?()
            } label: {
                Image(systemName: "arrow.left")
                    .foregroundColor(.black)
            }
            .frame(width: 44)
            Spacer()
            HStack(spacing: 8) {
                Button {
                    do {
                        try viewModel.bookmarkDidTap(news)
                    } catch {
                        onError?(error)
                    }
                } label: {
                    Image(systemName: viewModel.isInBookmark ? "bookmark.fill" : "bookmark")
                        .foregroundColor(.black)
                }
                .frame(width: 44)
                
                Button {
                    onShareTapped?(news)
                } label: {
                    Image(systemName: "arrowshape.turn.up.right")
                        .foregroundColor(.black)
                }
                .frame(width: 44)
            }
        }
        .padding(.init(top: 0, leading: 32, bottom: 0, trailing: 32))
        .frame(height: 68)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .background(Color.hex("F3EBE9").opacity(0.6))
        .background(.ultraThinMaterial)
        .clipShape(.rect(topLeadingRadius: 24, topTrailingRadius: 24))
    }
    
}

#Preview {
    NewsDetailView(viewModel: .init(), news: .init(url: .init(string: "https://www.wired.com/story/remarkable-paper-pro-digital-tablet/")))
}
