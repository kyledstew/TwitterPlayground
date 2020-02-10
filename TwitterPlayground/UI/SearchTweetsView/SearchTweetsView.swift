//
//  SearchTweetsView.swift
//  TwitterPlayground
//
//  Created by Kyle Stewart on 2/8/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import SwiftUI

struct SearchTweetsView: View {
    var viewModel: SearchTweetsViewModel

    @ObservedObject var state: SearchTweetsViewModel.State

    init() {
        viewModel = SearchTweetsViewModel()
        state = viewModel.state
    }

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    TextField("Search Tweet",
                              text: self.$state.searchKeyword,
                              onCommit: self.returnSelected)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                    List(self.state.results, id: \.id) { tweet in
                        Text(tweet.text)
                    }
                }

                ActivityIndicator(isAnimating: self.$state.loadingResults, style: .large)
            }
        .navigationBarTitle("Twitter Search")
        }
    }

    func returnSelected() {
        viewModel.notify(event: .searchSelected)
    }
}

struct SearchTweetsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTweetsView()
    }
}
