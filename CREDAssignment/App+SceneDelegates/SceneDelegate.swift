//
//  SceneDelegate.swift
//  CREDAssignment
//
//  Created by Vishal Bhogal on 16/09/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let viewModel = HomeViewModel()
        let rootVC = UINavigationController(rootViewController: OnboardingViewController(viewModel: viewModel))
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
    }
}
