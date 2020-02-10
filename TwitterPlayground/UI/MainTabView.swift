//
//  MainTabView.swift
//  TwitterPlayground
//
//  Created by Kyle Stewart on 2/9/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            SearchTweetsView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
            }

            TrendingView()
                .tabItem {
                    Image(systemName: "eye")
                    Text("Trending")
            }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
