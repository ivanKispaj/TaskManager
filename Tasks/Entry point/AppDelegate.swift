//
//  AppDelegate.swift
//  Tasks
//
//  Created by Ivan Konishchev on 02.01.2023.
//

import Foundation
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    @Published private(set) var deviceOrientation: String = UIDevice.current.orientation.isLandscape ? "Landscape" : "Portrait"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.rotated), name: UIDevice.orientationDidChangeNotification, object: nil)

        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let config = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        config.delegateClass = SceneDelegate.self
        return config
    }
    
    @objc func rotated() {
        if UIDevice.current.orientation.isLandscape {
            self.deviceOrientation = "Landscape"
        }

        if UIDevice.current.orientation.isPortrait {
            self.deviceOrientation = "Portrait"
        }
    }
}
