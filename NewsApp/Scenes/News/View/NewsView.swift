`//
//  NewsView.swift
//  NewsApp
//
//  Created by Muhammed Aralbek on 14.09.2024.
//

import SwiftUI

struct NewsView: View {
    
    @ObservedObject var viewModel: NewsVM
    
    var onNewsTapped: ClosureItem<NewsModel>?
    
    var body: some View {
        VStack(spacing: 16) {
            getNavBarView()
            getPicker()
            getNewsListView()
        }
    }
    
    @ViewBuilder
    private func getNavBarView() -> some View {
        Text("NewsApp")
            .font(.Inter(32, .semibold))
            .foregroundColor(.Text.primary)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(Color.hex("E9EEFA"))
    }
    
    @ViewBuilder
    private func getPicker() -> some View {
        HStack(spacing: 12) {
            ForEach(NewsTopic.allCases) { topic in
                let isSelected = viewModel.selectedTopic == topic
                let lightGray = Color.hex("E9EEFA")
                let backgroundColor = isSelected ? lightGray : Color.clear
                Button {
                    viewModel.selectedTopic = topic
                } label: {
                    Text(topic.name)
                        .font(.Inter(14, .semibold))
                        .foregroundStyle(Color.Text.primary)
                }
                .padding(.horizontal, 24)
                .frame(height: 32)
                .background(backgroundColor)
                .clipShape(.capsule)
                .overlay(
                    RoundedRectangle(cornerRadius: 32 / 2)
                        .stroke(lightGray, lineWidth: 1)
                )
                
            }
        }
    }
    
    @ViewBuilder
    private func getNewsListView() -> some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                ForEach(viewModel.news) { newsItem in
                    NewsCellView(news: newsItem)
                        .onTapGesture {
                            onNewsTapped?(newsItem)
                        }
                }
            }
            .padding(.horizontal, 32)
            .animation(.easeInOut(duration: 0.3), value: viewModel.news)
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView(viewModel: .init())
    }
}
`
