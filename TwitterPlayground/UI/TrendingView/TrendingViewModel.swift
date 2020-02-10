//
//  TrendingViewModel.swift
//  TwitterPlayground
//
//  Created by Kyle Stewart on 2/9/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import Foundation

class TrendingViewModel {
    var state: State

    init() {
        state = State()
    }
}

// MARK: - Objects used by ViewModel
extension TrendingViewModel {
    enum Event {
        case loadResults
        case resultsLoaded([Twitter.Trend])
        case error(Error)
    }

    class State: ObservableObject {
        @Published var loadingResults: Bool = false
        @Published var results: [Twitter.Trend] = []
    }
}

// MARK: - Conform to `ViewModel`
extension TrendingViewModel: ViewModel {
    func notify(event: TrendingViewModel.Event) {
        switch event {
        case .loadResults:
            state.loadingResults = true
            DispatchQueue.global(qos: .userInitiated).async {
                Actions.getTrendingNearMe(completion: self.handleLoadResult)
            }

        case let .resultsLoaded(trends):
            state.loadingResults = false
            state.results = trends

        case let .error(error):
            state.loadingResults = false
            print(error)
        }
    }

    func handleLoadResult(_ result: (Result<[Twitter.Trend], Error>)) {
        switch result {
        case let .success(trends):
            DispatchQueue.main.async {
                self.notify(event: .resultsLoaded(trends))
            }

        case let .failure(error):
            DispatchQueue.main.async {
                self.notify(event: .error(error))
            }
        }
    }
}
