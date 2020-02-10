//
//  SceneDelegate.swift
//  TwitterPlayground
//
//  Created by Kyle Stewart on 2/8/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import UIKit
import SwiftUI

@UIApplicationMain
class SceneDelegate: UIResponder, UIWindowSceneDelegate, UIApplicationDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        let contentView = MainTabView()

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
