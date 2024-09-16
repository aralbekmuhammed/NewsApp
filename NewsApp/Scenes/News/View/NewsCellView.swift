//
//  NewsCellView.swift
//  NewsApp
//
//  Created by Muhammed Aralbek on 16.09.2024.
//

import SwiftUI
import Kingfisher

struct NewsCellView: View {
    
    let news: NewsModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(news.title ?? "")
                    .font(.Inter(18, .semibold))
                    .lineLimit(2)
                
                HStack(spacing: 4) {
                    Text(news.author ?? "")
                    if news.author != nil && news.dateCreated != nil {
                        Text("·")
                    }
                    Text(news.dateCreated?.formatted(dateFormat: "MMMM d, yyyy") ?? "")
                }
                .font(.Inter(12, .regular))
                .foregroundColor(.gray)
                
            }
            Spacer(minLength: 16)
            
            KFImage(news.urlToImage)
                .resizable()
                .fade(duration: 0.25)
                .placeholder({ Color.gray.opacity(0.4) })
                .scaledToFill()
                .frame(width: 112, height: 80)
                .cornerRadius(10)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    NewsCellView(news: NewsModel(title: "Test", description: "Description", urlToImage: .init(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_pI1f_vzn6i4ZuTcfVy-aWurvLxC47R3zRw&s"), author: "Author name", publishedAt: "2024-08-28T19:05:36Z"))
}
