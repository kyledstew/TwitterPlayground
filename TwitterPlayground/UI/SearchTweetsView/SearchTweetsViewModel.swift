//
//  SearchTweetsViewModel.swift
//  TwitterPlayground
//
//  Created by Kyle Stewart on 2/9/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import Foundation

class SearchTweetsViewModel {
    var state: State

    init() {
        state = State()
    }
}

// MARK: - Objects used by ViewModel
extension SearchTweetsViewModel {
    enum Event {
        case searchSelected
        case resultsLoaded([Twitter.Tweet])
        case error(Error)
    }

    class State: ObservableObject {
        @Published var searchKeyword: String = ""
        @Published var loadingResults: Bool = false
        @Published var results: [Twitter.Tweet] = []
    }
}

// MARK: - Conform to `ViewModel`
extension SearchTweetsViewModel: ViewModel {
    func notify(event: SearchTweetsViewModel.Event) {
        switch event {
        case .searchSelected:
            guard !state.searchKeyword.isEmpty else { break }
            state.results.removeAll()
            state.loadingResults = true
            DispatchQueue.global(qos: .userInitiated).async {
                Actions.searchTweets(keyword: self.state.searchKeyword,
                                     completion: self.handleSearchResult)
            }

        case let .resultsLoaded(tweets):
            state.loadingResults = false
            state.results.append(contentsOf: tweets)

        case let .error(error):
            state.loadingResults = false
            print(error)
        }
    }

    func handleSearchResult(_ result: (Result<[Twitter.Tweet], Error>)) {
        switch result {
        case let .success(tweets):
            DispatchQueue.main.async {
                self.notify(event: .resultsLoaded(tweets))
            }

        case let .failure(error):
            DispatchQueue.main.async {
                self.notify(event: .error(error))
            }
        }
    }
}
