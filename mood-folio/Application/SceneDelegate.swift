//
//  SceneDelegate.swift
//  mood-folio
//
//  Created by junehee on 7/22/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let isUser = UserDefaultsManager.isUser
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        if isUser {
            let tabBarController = UITabBarController()
            tabBarController.view.backgroundColor = Resource.Color.white
            tabBarController.tabBar.tintColor = Resource.Color.black
            
            let topic = UINavigationController(rootViewController: TopicViewController())
            let random = UINavigationController(rootViewController: RandomViewController())
            let search = UINavigationController(rootViewController: SearchViewController())
            let like = UINavigationController(rootViewController: LikeViewController())
            
            let viewControllers = [topic, random, search, like]
            tabBarController.setViewControllers(viewControllers, animated: true)
            
            if let items = tabBarController.tabBar.items {
                for i in 0..<items.count {
                    items[i].image = Resource.SystemImage.tabBarImages[i]
                }
            }
            
            window?.rootViewController = tabBarController
        } else {
            let onboarding = UINavigationController(rootViewController: OnboardingViewController())
            window?.rootViewController = onboarding
        }
        
        window?.makeKeyAndVisible()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

