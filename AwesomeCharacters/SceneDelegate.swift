//
//  SceneDelegate.swift
//  AwesomeCharacters
//
//  Created by rafael.fernandez on 27/11/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UINavigationController(rootViewController: ListCharacterViewController())
            window.makeKeyAndVisible()
            self.window = window
        }
    }
}

