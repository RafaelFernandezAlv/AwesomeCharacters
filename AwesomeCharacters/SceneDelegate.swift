//
//  SceneDelegate.swift
//  AwesomeCharacters
//
//  Created by rafael.fernandez on 27/11/21.
//

import UIKit
import Kingfisher

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        configureKingfisher()
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UINavigationController(rootViewController: ListCharacterViewController())
            window.makeKeyAndVisible()
            self.window = window
        }
    }
    
    func configureKingfisher() {
        ImageCache.default.memoryStorage.config.totalCostLimit = 1024 * 1024 * 40 // 40 Mb max memory cache
    }
}

