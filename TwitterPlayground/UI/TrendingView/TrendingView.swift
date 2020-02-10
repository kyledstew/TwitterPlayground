//
//  TrendingView.swift
//  TwitterPlayground
//
//  Created by Kyle Stewart on 2/9/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import SwiftUI

struct TrendingView: View {
    var viewModel: TrendingViewModel

    @ObservedObject var state: TrendingViewModel.State

    init() {
        viewModel = TrendingViewModel()
        state = viewModel.state
    }

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    List(self.state.results, id: \.name) { trend in
                        Text(trend.name)
                    }
                }

                ActivityIndicator(isAnimating: self.$state.loadingResults, style: .large)
            }
        .navigationBarTitle("Trending Near Me")
        }
        .onAppear {
            self.viewModel.notify(event: .loadResults)
        }
    }
}
