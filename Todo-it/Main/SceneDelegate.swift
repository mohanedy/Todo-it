//
//  SceneDelegate.swift
//  Todo-it
//
//  Created by Mohaned Yossry on 4/14/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let isShown = UserDefaults.standard.bool(forKey: "isShown")
        print(isShown)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if isShown {
            //Showing blue View Controller
            let mainViewController = storyboard.instantiateViewController(withIdentifier: "categoryScreen")
            
            self.window = self.window ?? UIWindow()
            self.window!.rootViewController = mainViewController
            self.window!.makeKeyAndVisible()
        } else {
            let welcomeVC = storyboard.instantiateViewController(withIdentifier: "welcomeScreen")
            self.window = self.window ?? UIWindow()
            
            self.window!.rootViewController = welcomeVC
            self.window!.makeKeyAndVisible()
        }
        guard let _ = (scene as? UIWindowScene) else { return }
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
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

