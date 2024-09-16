//
//  PaywallView.swift
//  NewsApp
//
//  Created by Muhammed Aralbek on 13.09.2024.
//

import SwiftUI

struct PaywallView: View {
    
    @ObservedObject var viewModel: PaywallViewModel
    
    var onDismissTapped: Closure?
    
    var onError: ClosureItem<Error>?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            getBackgroundView()
            getBottomSheetView()
        }
        .ignoresSafeArea(edges: .bottom)
    }
    
    @ViewBuilder
    private func getBackgroundView() -> some View {
        GeometryReader { geo in
            ZStack(alignment: .topLeading) {
                Group {
                    LinearGradient(colors: [Color.hex("2249D4"), Color.hex("E9EEFA")],
                                   startPoint: .top, endPoint: .bottom)
                    Image(.Common.paywallBackground)
                        .resizable()
                        .scaledToFill()
                        .frame(height: geo.size.height / 1.5, alignment: .top)
                }
                .ignoresSafeArea()
                
                Button {
                    onDismissTapped?()
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(.white)
                        .frame(width: 16, height: 16)
                        .padding(.horizontal, 8)
                        .font(Font.title.weight(.semibold))
                }
                .padding(16)
            }
        }
    }
    
    @ViewBuilder
    private func getBottomSheetView() -> some View {
        VStack(spacing: 50) {
            VStack(spacing: 20) {
                Text("NewsApp Premium")
                    .font(.Inter(32, .semibold))
                    .foregroundStyle(Color.Text.primary)
                Text("NewsApp brings you the world’s best journalism, all in one place. Trusted sources, curated by editors, and personalized for you.")
                    .font(.Inter(18, .regular))
                    .foregroundStyle(Color.Text.secondary)
            }
            VStack(spacing: 12, content: {
                Text("$4.49 per month")
                    .font(.Inter(16, .bold))
                    .foregroundStyle(Color.Text.primary)
                
                Button {
                    Task {
                        do {
                            try await viewModel.subscribe()
                        } catch {
                            onError?(error)
                        }
                    }
                } label: {
                    Text("Subscribe")
                        .font(.Inter(22, .bold))
                        .foregroundStyle(Color.white)
                }
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color.hex("D32621"))
                .cornerRadius(22)
                
                GeometryReader { geo in
                    
                    HStack(spacing: 0) {
                        ForEach(PaywallActions.allCases) { action in
                            Button {
                                if action == .restore {
                                    viewModel.restore()
                                }
                            } label: {
                                Text(action.name)
                                    .frame(width: geo.size.width / CGFloat(PaywallActions.allCases.count), height: geo.size.height)
                            }
                        }
                    }
                }
                .frame(height: 40)
                .font(.Inter(12, .bold))
                .foregroundStyle(Color.Text.primary)
            })
            
        }
        .padding(.init(top: 52, leading: 32, bottom: 24, trailing: 32))
        .background(Color.BG.primary)
        .clipShape(.rect(cornerRadii: .init(topLeading: 32, topTrailing: 32)))
    }
    
}

#Preview {
    PaywallView(viewModel: .init())
}
